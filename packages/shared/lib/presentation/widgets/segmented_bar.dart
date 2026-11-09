import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/striped_fill.dart';

class const SegmentedBarPart({
  required final int value,
  required final Color color,
  final Color? stripeColor,
});

class const SegmentedBar({
  super.key,
  required final List<SegmentedBarPart> _parts,
  final int? _total,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final parts = [
      for (final part in _parts)
        if (part.value > 0) part,
    ];
    final filled = parts.fold(0, (sum, part) => sum + part.value);
    final rest = (_total ?? filled) - filled;
    return SizedBox(
      height: Spacing.s,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Spacing.xxxs,
        children: [
          for (final part in parts)
            Expanded(
              flex: part.value,
              child: _Segment(color: part.color, stripeColor: part.stripeColor),
            ),
          if (rest > 0)
            Expanded(
              flex: rest,
              child: _Segment(color: context.c.surfaceContainer),
            ),
          if (filled == 0 && rest <= 0)
            Expanded(child: _Segment(color: context.c.surfaceContainerLowest)),
        ],
      ),
    );
  }
}

class const _Segment({
  required final Color _color,
  final Color? _stripeColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusFull),
      child: switch (_stripeColor) {
        final stripeColor? => StripedFill(color: stripeColor, background: _color),
        null => ColoredBox(color: _color),
      },
    );
  }
}
