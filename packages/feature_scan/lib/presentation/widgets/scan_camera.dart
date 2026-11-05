import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/error/app_error.dart';
import 'package:feature_scan/presentation/extensions/camera_exception_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _resolution = ResolutionPreset.high;
const _defaultZoom = 1.0;

ScanCamera useScanCamera() {
  final camera = useMemoized(ScanCamera.new);
  useEffect(() {
    unawaited(camera.start());
    return camera.dispose;
  }, [camera]);
  useOnAppLifecycleStateChange((_, state) => camera.onLifecycleChanged(state));
  return useListenable(camera);
}

class ScanCamera extends ChangeNotifier {
  CameraController? _controller;
  AppError? _error;
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = 0;
  double _zoom = _defaultZoom;
  double _minZoom = _defaultZoom;
  double _maxZoom = _defaultZoom;
  double _exposure = 0;
  double _minExposure = 0;
  double _maxExposure = 0;
  bool _isFlashOn = false;
  bool _isTakingPicture = false;
  Future<void>? _starting;
  bool _needsRestart = false;
  bool _isDisposed = false;

  CameraController? get controller => _controller;

  AppError? get error => _error;

  double get zoom => _zoom;

  double get minZoom => _minZoom;

  double get maxZoom => _maxZoom;

  double get exposure => _exposure;

  double get minExposure => _minExposure;

  double get maxExposure => _maxExposure;

  bool get isFlashOn => _isFlashOn;

  bool get isTakingPicture => _isTakingPicture;

  bool get isReady => _controller?.value.isInitialized ?? false;

  bool get canSwitch => isReady && _cameras.length > 1;

  bool get canAdjustExposure => _maxExposure > _minExposure;

  Future<void> start() => _starting ??= _start().whenComplete(() => _starting = null);

  Future<void> retry() async {
    _error = null;
    notifyListeners();
    if (!isReady) await start();
  }

  Future<void> switchLens() async {
    final controller = _controller;
    if (controller == null || _cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    try {
      await controller.setDescription(_cameras[_cameraIndex]);
      await _readRanges(controller);
      _isFlashOn = false;
      if (!_isDisposed) notifyListeners();
    } on CameraException catch (exception) {
      _fail(exception.toAppError());
    }
  }

  Future<void> setZoom(double zoom) async {
    _zoom = zoom.clamp(_minZoom, _maxZoom);
    notifyListeners();
    try {
      await _controller?.setZoomLevel(_zoom);
    } on CameraException catch (exception) {
      _fail(exception.toAppError());
    }
  }

  Future<void> toggleFlash() async {
    final controller = _controller;
    if (controller == null) return;
    final isOn = !_isFlashOn;
    try {
      await controller.setFlashMode(isOn ? FlashMode.always : FlashMode.off);
      _isFlashOn = isOn;
      if (!_isDisposed) notifyListeners();
    } on CameraException {
      return;
    }
  }

  Future<void> focusAt(Offset point, {required bool locks}) async {
    final controller = _controller;
    if (controller == null || !isReady) return;
    try {
      if (controller.value.exposurePointSupported) await controller.setExposurePoint(point);
      if (controller.value.focusPointSupported) await controller.setFocusPoint(point);
      await controller.setFocusMode(locks ? FocusMode.locked : FocusMode.auto);
      await controller.setExposureMode(locks ? ExposureMode.locked : ExposureMode.auto);
    } on CameraException {
      return;
    }
  }

  Future<void> setExposure(double exposure) async {
    _exposure = exposure.clamp(_minExposure, _maxExposure);
    notifyListeners();
    try {
      await _controller?.setExposureOffset(_exposure);
    } on CameraException {
      return;
    }
  }

  Future<String?> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _isTakingPicture) return null;
    _isTakingPicture = true;
    notifyListeners();
    try {
      return (await controller.takePicture()).path;
    } on CameraException catch (exception) {
      _fail(exception.toAppError());
      return null;
    } finally {
      _isTakingPicture = false;
      if (!_isDisposed) notifyListeners();
    }
  }

  // * The permission dialog makes the app inactive while the camera is still starting, so only a
  // * camera that is running is stopped on inactive. Leaving the app (for example to the system
  // * settings) always restarts it on return, which picks up a permission granted there.
  void onLifecycleChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_needsRestart) return;
        _needsRestart = false;
        _error = null;
        unawaited(start());
      case AppLifecycleState.inactive:
        if (!isReady) return;
        _needsRestart = true;
        unawaited(_stop());
      case AppLifecycleState.hidden || AppLifecycleState.paused:
        _needsRestart = true;
        if (isReady) unawaited(_stop());
      case AppLifecycleState.detached:
        return;
    }
  }

  Future<void> _start() async {
    if (isReady || _isDisposed) return;
    CameraController? next;
    try {
      if (_cameras.isEmpty) _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _fail(const CameraUnavailableError());
        return;
      }
      next = CameraController(_cameras[_cameraIndex], _resolution, enableAudio: false);
      await next.initialize();
      await next.setFlashMode(FlashMode.off);
      await _readRanges(next);
      if (_isDisposed) {
        await next.dispose();
        return;
      }
      _controller = next;
      _isFlashOn = false;
      _error = null;
      notifyListeners();
    } on CameraException catch (exception) {
      await next?.dispose();
      _fail(exception.toAppError());
    }
  }

  Future<void> _readRanges(CameraController controller) async {
    _minZoom = await controller.getMinZoomLevel();
    _maxZoom = await controller.getMaxZoomLevel();
    _zoom = _defaultZoom.clamp(_minZoom, _maxZoom);
    _minExposure = await controller.getMinExposureOffset();
    _maxExposure = await controller.getMaxExposureOffset();
    _exposure = 0;
  }

  Future<void> _stop() async {
    final controller = _controller;
    _controller = null;
    if (!_isDisposed) notifyListeners();
    await controller?.dispose();
  }

  void _fail(AppError error) {
    if (_isDisposed) return;
    _error = error;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    unawaited(_controller?.dispose());
    _controller = null;
    super.dispose();
  }
}
