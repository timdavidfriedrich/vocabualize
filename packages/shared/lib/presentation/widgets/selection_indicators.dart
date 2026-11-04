import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _indicatorSize = Spacing.xl;
const _dotSize = Spacing.xs;
const _animationDuration = Duration(milliseconds: 150);

class const CheckIndicator({
  super.key,
  required final bool? _isChecked,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFilled = _isChecked != false;
    return AnimatedContainer(
      duration: _animationDuration,
      width: _indicatorSize,
      height: _indicatorSize,
      decoration: BoxDecoration(
        color: isFilled ? context.c.primary : context.c.surfaceContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusS),
      ),
      child: switch (_isChecked) {
        true => Icon(Icons.check_rounded, size: Spacing.iconS, color: context.c.onPrimary),
        null => Icon(Icons.remove_rounded, size: Spacing.iconS, color: context.c.onPrimary),
        false => null,
      },
    );
  }
}

class const RadioIndicator({
  super.key,
  required final bool _isSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      width: _indicatorSize,
      height: _indicatorSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _isSelected ? context.c.primary : context.c.surfaceContainer,
      ),
      child: _isSelected
          ? Container(
              width: _dotSize,
              height: _dotSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.c.onPrimary),
            )
          : null,
    );
  }
}
