import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/extensions/zoom_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _pillOpacity = 0.6;
const _trackOpacity = 0.7;
const _rulerTicks = 9;
const _rulerTickHeight = Spacing.s;
const _rulerCenterTickHeight = Spacing.l;

class const ZoomIndicator({
  super.key,
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
