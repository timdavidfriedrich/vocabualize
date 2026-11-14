import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/widgets/exposure_slider.dart';
import 'package:feature_scan/presentation/widgets/focus_locked_pill.dart';
import 'package:feature_scan/presentation/widgets/focus_ring.dart';
import 'package:feature_scan/presentation/widgets/scan_camera.dart';
import 'package:feature_scan/presentation/widgets/zoom_indicator.dart';
import 'package:feature_scan/presentation/widgets/zoom_presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _focusHideDelay = Duration(seconds: 3);

class const CameraPreviewBox({
  super.key,
  required final ScanCamera _camera,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      child: ColoredBox(
        color: context.c.surfaceContainerLowest,
        child: switch ((_camera.error, _camera.controller)) {
          (final AppError error, _) => _CameraFailure(error: error, onRetried: _camera.retry),
          (null, final CameraController controller) when controller.value.isInitialized =>
            _LivePreview(camera: _camera, controller: controller),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class const _LivePreview({
  required final ScanCamera _camera,
  required final CameraController _controller,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final focus = useState<Offset?>(null);
    final isLocked = useState(false);
    final isZooming = useState(false);
    final focusTick = useState(0);
    final baseZoom = useRef(_camera.zoom);
    useEffect(() {
      if (focus.value == null || isLocked.value) return null;
      final timer = Timer(_focusHideDelay, () => focus.value = null);
      return timer.cancel;
    }, [focusTick.value, isLocked.value]);
    final previewSize = _controller.value.previewSize;
    final previewWidth = previewSize?.height ?? 1;
    final previewHeight = previewSize?.width ?? 1;
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = constraints.maxWidth;
        final scale = max(side / previewWidth, side / previewHeight);
        Offset toPreviewPoint(Offset position) => Offset(
          ((position.dx + (previewWidth * scale - side) / 2) / (previewWidth * scale)).clamp(0, 1),
          ((position.dy + (previewHeight * scale - side) / 2) / (previewHeight * scale)).clamp(
            0,
            1,
          ),
        );
        void focusAt(Offset position, {required bool locks}) {
          focus.value = position;
          isLocked.value = locks;
          focusTick.value++;
          unawaited(_camera.focusAt(toPreviewPoint(position), locks: locks));
        }

        return GestureDetector(
          onTapUp: (details) => focusAt(details.localPosition, locks: false),
          onLongPressStart: (details) {
            unawaited(Feedback.forLongPress(context));
            focusAt(details.localPosition, locks: true);
          },
          onScaleStart: (_) => baseZoom.value = _camera.zoom,
          onScaleUpdate: (details) {
            if (details.pointerCount < 2) return;
            isZooming.value = true;
            unawaited(_camera.setZoom(baseZoom.value * details.scale));
          },
          onScaleEnd: (_) => isZooming.value = false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: previewWidth,
                  height: previewHeight,
                  child: CameraPreview(_controller),
                ),
              ),
              if (focus.value case final point?) ...[
                Positioned(
                  left: point.dx - focusRingSize / 2,
                  top: point.dy - focusRingSize / 2,
                  child: IgnorePointer(child: FocusRing(isLocked: isLocked.value)),
                ),
                if (_camera.canAdjustExposure)
                  Positioned(
                    left: min(point.dx + focusRingSize / 2 + Spacing.xs, side - Spacing.xl),
                    top: point.dy - exposureTrackHeight / 2,
                    child: ExposureSlider(camera: _camera, onUsed: () => focusTick.value++),
                  ),
              ],
              if (isLocked.value)
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(padding: EdgeInsets.all(Spacing.s), child: FocusLockedPill()),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.s),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isZooming.value) ...[
                        ZoomIndicator(zoom: _camera.zoom),
                        const SizedBox(height: Spacing.xs),
                      ],
                      ZoomPresets(
                        camera: _camera,
                        onSliding: (isSliding) => isZooming.value = isSliding,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
