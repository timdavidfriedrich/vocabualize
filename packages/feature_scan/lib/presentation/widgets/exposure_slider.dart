import 'dart:async';

import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/widgets/scan_camera.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _trackOpacity = 0.7;
const exposureTrackHeight = Spacing.xxxxxl - Spacing.m;
const _shadowBlur = Spacing.xxs;

class const ExposureSlider({
  super.key,
  required final ScanCamera _camera,
  required final VoidCallback _onUsed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final range = _camera.maxExposure - _camera.minExposure;
    final position = (_camera.exposure - _camera.minExposure) / range;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        final delta = -details.delta.dy / (exposureTrackHeight - Spacing.iconM) * range;
        unawaited(_camera.setExposure(_camera.exposure + delta));
        _onUsed();
      },
      child: SizedBox(
        width: Spacing.iconM,
        height: exposureTrackHeight,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: Spacing.borderWidthThin,
                color: context.overlay.onScrim.withValues(alpha: _trackOpacity),
              ),
            ),
            Positioned(
              top: (1 - position) * (exposureTrackHeight - Spacing.iconM),
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
