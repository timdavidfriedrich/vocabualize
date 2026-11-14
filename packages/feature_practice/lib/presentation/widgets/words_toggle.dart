import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/pill_segment.dart';

class const WordsToggle({
  super.key,
  required final bool _isAll,
  required final VoidCallback _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(color: context.c.primaryContainer, shape: const StadiumBorder()),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xxxs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToggleSegment(
              label: context.s.customPracticeDueLabel,
              isSelected: !_isAll,
              onTap: _isAll ? _onChanged : null,
            ),
            _ToggleSegment(
              label: context.s.customPracticeAllWordsOption,
              isSelected: _isAll,
              onTap: _isAll ? null : _onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class const _ToggleSegment({
  required final String _label,
  required final bool _isSelected,
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PillSegment(
      isSelected: _isSelected,
      onTap: _onTap,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
      child: Text(
        _label,
        style: context.t.labelLarge?.copyWith(
          color: _isSelected ? context.c.onPrimary : context.c.primary,
        ),
      ),
    );
  }
}
