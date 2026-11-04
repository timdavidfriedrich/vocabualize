import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const SegmentedBarPart({
  required final int value,
  required final Color color,
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
              child: _Segment(color: part.color),
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
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
    );
  }
}
