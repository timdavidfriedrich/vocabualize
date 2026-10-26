import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/extensions/camera_exception_extensions.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _resolution = ResolutionPreset.high;
const _minZoom = 1.0;
const _controlsOpacity = 0.25;

class const ScanCameraView({
  super.key,
  required final bool _isProcessing,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final camera = _useScanCamera();
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
            children: [
              const SizedBox(height: Spacing.m),
              AspectRatio(
                aspectRatio: 1,
                child: _CameraBox(camera: camera),
              ),
              const SizedBox(height: Spacing.xxl),
              IntrinsicHeight(
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: _SwitchCameraButton(
                        onPressed: camera.canSwitch ? camera.switchLens : null,
                      ),
                    ),
                    const SizedBox(width: Spacing.m),
                    Expanded(
                      child: _ZoomSlider(
                        zoom: camera.zoom,
                        maxZoom: camera.maxZoom,
                        onChanged: camera.isReady ? camera.setZoom : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FloatingActionButton.large(
          heroTag: null,
          backgroundColor: context.c.surfaceContainerLow,
          onPressed: camera.isReady && !_isProcessing ? () => _takePhoto(context, camera) : null,
          child: _isProcessing
              ? const CircularProgressIndicator()
              : const Icon(Icons.camera_alt_rounded),
        ),
        const SizedBox(height: Spacing.xxl),
      ],
    );
  }

  Future<void> _takePhoto(BuildContext context, _ScanCamera camera) async {
    final bloc = context.read<ScanBloc>();
    final path = await camera.takePicture();
    if (path != null) bloc.add(ScanPhotoTaken(path: path));
  }
}

class const _CameraBox({
  required final _ScanCamera _camera,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      child: ColoredBox(
        color: context.c.surfaceContainerLow,
        child: switch ((_camera.error, _camera.controller)) {
          (final AppError error, _) => _CameraFailure(error: error, onRetried: _camera.retry),
          (null, final CameraController controller) when controller.value.isInitialized =>
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.previewSize?.height,
                height: controller.value.previewSize?.width,
                child: CameraPreview(controller),
              ),
            ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class const _CameraFailure({
  required final AppError _error,
  required final VoidCallback _onRetried,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_error.toMessage(context), textAlign: TextAlign.center),
          const SizedBox(height: Spacing.m),
          switch (_error) {
            CameraPermissionError() => ElevatedButton(
              onPressed: () => context.read<ScanBloc>().add(const ScanSettingsOpened()),
              child: Text(context.s.scanOpenSettingsButton),
            ),
            _ => ElevatedButton(
              onPressed: _onRetried,
              child: Text(context.s.tryAgain),
            ),
          },
        ],
      ),
    );
  }
}

class const _SwitchCameraButton({
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerLow.withValues(alpha: _controlsOpacity),
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      child: InkWell(
        onTap: _onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: Icon(Icons.cameraswitch_rounded, color: context.c.primary),
        ),
      ),
    );
  }
}

class const _ZoomSlider({
  required final double _zoom,
  required final double _maxZoom,
  required final ValueChanged<double>? _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow.withValues(alpha: _controlsOpacity),
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      ),
      child: Slider.adaptive(
        value: _zoom.clamp(_minZoom, _maxZoom),
        min: _minZoom,
        max: _maxZoom,
        onChanged: _onChanged,
      ),
    );
  }
}

_ScanCamera _useScanCamera() {
  final camera = useMemoized(_ScanCamera.new);
  useEffect(() {
    unawaited(camera.start());
    return camera.dispose;
  }, [camera]);
  useOnAppLifecycleStateChange((_, state) => camera.onLifecycleChanged(state));
  return useListenable(camera);
}

class _ScanCamera extends ChangeNotifier {
  CameraController? _controller;
  AppError? _error;
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = 0;
  double _zoom = _minZoom;
  double _maxZoom = _minZoom;
  Future<void>? _starting;
  bool _needsRestart = false;
  bool _isDisposed = false;

  CameraController? get controller => _controller;

  AppError? get error => _error;

  double get zoom => _zoom;

  double get maxZoom => _maxZoom;

  bool get isReady => _controller?.value.isInitialized ?? false;

  bool get canSwitch => isReady && _cameras.length > 1;

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
      _zoom = _minZoom;
      _maxZoom = await controller.getMaxZoomLevel();
      if (!_isDisposed) notifyListeners();
    } on CameraException catch (exception) {
      _fail(exception.toAppError());
    }
  }

  Future<void> setZoom(double zoom) async {
    _zoom = zoom;
    notifyListeners();
    try {
      await _controller?.setZoomLevel(zoom);
    } on CameraException catch (exception) {
      _fail(exception.toAppError());
    }
  }

  Future<String?> takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || controller.value.isTakingPicture) {
      return null;
    }
    try {
      return (await controller.takePicture()).path;
    } on CameraException catch (exception) {
      _fail(exception.toAppError());
      return null;
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
      final maxZoom = await next.getMaxZoomLevel();
      if (_isDisposed) {
        await next.dispose();
        return;
      }
      _controller = next;
      _zoom = _minZoom;
      _maxZoom = maxZoom;
      _error = null;
      notifyListeners();
    } on CameraException catch (exception) {
      await next?.dispose();
      _fail(exception.toAppError());
    }
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
