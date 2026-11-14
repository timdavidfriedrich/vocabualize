import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';

const _countStep = 5;
const _countWidth = Spacing.xxxl;

class const CountRow({
  super.key,
  required final Widget _leading,
  required final int _count,
  required final int _maximum,
  required final ValueChanged<int> _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.xs, Spacing.xs, Spacing.xs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
      ),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: _leading,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: _count <= 0
                ? null
                : () => _onChanged(((_count - 1) ~/ _countStep) * _countStep),
            tooltip: context.s.customPracticeFewerTooltip,
            icon: const Icon(Icons.remove_rounded),
          ),
          SizedBox(
            width: _countWidth,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(_count.toCountLabel(context), style: context.t.headlineSmall),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: _count >= _maximum
                ? null
                : () => _onChanged((_count ~/ _countStep + 1) * _countStep),
            tooltip: context.s.customPracticeMoreTooltip,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
