import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/extensions/zoom_extensions.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/widgets/scan_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _focusRingSize = Spacing.xxxxl + Spacing.s;
const _exposureTrackHeight = Spacing.xxxxl * 2 - Spacing.m;
const _focusHideDelay = Duration(seconds: 3);
const _zoomPresets = [0.5, 1.0, 2.0, 5.0];
const _zoomTolerance = 0.05;
const _presetSize = Spacing.xxxl - Spacing.xs;
const _barOpacity = 0.4;
const _pillOpacity = 0.6;
const _selectedPresetOpacity = 0.2;
const _trackOpacity = 0.7;
const _rulerTicks = 9;
const _rulerTickHeight = Spacing.s;
const _rulerCenterTickHeight = Spacing.l;
const _shadowBlur = Spacing.xxs;

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
                  left: point.dx - _focusRingSize / 2,
                  top: point.dy - _focusRingSize / 2,
                  child: IgnorePointer(child: _FocusRing(isLocked: isLocked.value)),
                ),
                if (_camera.canAdjustExposure)
                  Positioned(
                    left: min(point.dx + _focusRingSize / 2 + Spacing.xs, side - Spacing.xl),
                    top: point.dy - _exposureTrackHeight / 2,
                    child: _ExposureSlider(camera: _camera, onUsed: () => focusTick.value++),
                  ),
              ],
              if (isLocked.value)
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(padding: EdgeInsets.all(Spacing.s), child: _FocusLockedPill()),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.s),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isZooming.value) ...[
                        _ZoomIndicator(zoom: _camera.zoom),
                        const SizedBox(height: Spacing.xs),
                      ],
                      _ZoomPresets(camera: _camera),
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

class const _FocusRing({
  required final bool _isLocked,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _focusRingSize,
      height: _focusRingSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _isLocked ? context.c.primary : context.overlay.onScrim,
          width: Spacing.borderWidthMedium,
        ),
      ),
    );
  }
}

class const _ExposureSlider({
  required final ScanCamera _camera,
  required final VoidCallback _onUsed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final range = _camera.maxExposure - _camera.minExposure;
    final position = (_camera.exposure - _camera.minExposure) / range;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        final delta = -details.delta.dy / (_exposureTrackHeight - Spacing.iconM) * range;
        unawaited(_camera.setExposure(_camera.exposure + delta));
        _onUsed();
      },
      child: SizedBox(
        width: Spacing.iconM,
        height: _exposureTrackHeight,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: Spacing.borderWidthThin,
                color: context.overlay.onScrim.withValues(alpha: _trackOpacity),
              ),
            ),
            Positioned(
              top: (1 - position) * (_exposureTrackHeight - Spacing.iconM),
              child: Icon(
                Icons.wb_sunny_outlined,
                color: context.overlay.onScrim,
                shadows: [Shadow(color: context.overlay.scrim, blurRadius: _shadowBlur)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _FocusLockedPill() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.overlay.scrim.withValues(alpha: _pillOpacity),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline_rounded, size: Spacing.iconS, color: context.c.primary),
            const SizedBox(width: Spacing.xs),
            Text(
              context.s.scanFocusLockedLabel,
              style: context.t.labelLarge?.copyWith(color: context.c.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class const _ZoomIndicator({
  required final double _zoom,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: ShapeDecoration(
            color: context.overlay.scrim.withValues(alpha: _pillOpacity),
            shape: const StadiumBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxxs),
            child: Text(
              _zoom.toZoomLabel(context),
              style: context.t.labelLarge?.copyWith(color: context.overlay.onScrim),
            ),
          ),
        ),
        const SizedBox(height: Spacing.xs),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: Spacing.xs,
          children: [
            for (var index = 0; index < _rulerTicks; index++)
              Container(
                width: Spacing.borderWidthMedium,
                height: index == _rulerTicks ~/ 2 ? _rulerCenterTickHeight : _rulerTickHeight,
                color: index == _rulerTicks ~/ 2
                    ? context.c.primary
                    : context.overlay.onScrim.withValues(alpha: _trackOpacity),
              ),
          ],
        ),
      ],
    );
  }
}

class const _ZoomPresets({
  required final ScanCamera _camera,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presets = [
      for (final preset in _zoomPresets)
        if (preset >= _camera.minZoom - _zoomTolerance && preset <= _camera.maxZoom) preset,
    ];
    if (presets.length < 2) return const SizedBox.shrink();
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.overlay.scrim.withValues(alpha: _barOpacity),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xxxs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacing.xs,
          children: [
            for (final preset in presets)
              _PresetButton(
                preset: preset,
                isSelected: (_camera.zoom - preset).abs() < _zoomTolerance,
                onPressed: () => _camera.setZoom(preset),
              ),
          ],
        ),
      ),
    );
  }
}

class const _PresetButton({
  required final double _preset,
  required final bool _isSelected,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _presetSize,
      child: Material(
        color: _isSelected
            ? context.overlay.onScrim.withValues(alpha: _selectedPresetOpacity)
            : context.overlay.onScrim.withValues(alpha: 0),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onPressed,
          child: Center(
            child: Text(
              _preset.toZoomPresetLabel(context, isSelected: _isSelected),
              style: context.t.labelLarge?.copyWith(
                color: _isSelected ? context.c.primary : context.overlay.onScrim,
              ),
            ),
          ),
        ),
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
