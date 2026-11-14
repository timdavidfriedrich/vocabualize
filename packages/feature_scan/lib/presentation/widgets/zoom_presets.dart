import 'dart:async';
import 'dart:math';

import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/extensions/zoom_extensions.dart';
import 'package:feature_scan/presentation/widgets/scan_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _zoomPresets = [0.5, 1.0, 2.0, 5.0];
const _zoomTolerance = 0.05;
const _presetSize = Spacing.controlHeightS;
const _barOpacity = 0.4;
const _selectedPresetOpacity = 0.2;
const _slidePerDoubling = Spacing.xxxxl;

class const ZoomPresets({
  super.key,
  required final ScanCamera _camera,
  required final ValueChanged<bool> _onSliding,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final startZoom = useRef(_camera.zoom);
    final slide = useRef(0.0);
    final presets = [
      for (final preset in _zoomPresets)
        if (preset >= _camera.minZoom - _zoomTolerance && preset <= _camera.maxZoom) preset,
    ];
    if (presets.length < 2) return const SizedBox.shrink();
    void endSlide() => _onSliding(false);
    return GestureDetector(
      onHorizontalDragStart: (_) {
        startZoom.value = _camera.zoom;
        slide.value = 0;
        _onSliding(true);
      },
      onHorizontalDragUpdate: (details) {
        slide.value += details.delta.dx;
        unawaited(_camera.setZoom(startZoom.value * pow(2, slide.value / _slidePerDoubling)));
      },
      onHorizontalDragEnd: (_) => endSlide(),
      onHorizontalDragCancel: endSlide,
      child: DecoratedBox(
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
