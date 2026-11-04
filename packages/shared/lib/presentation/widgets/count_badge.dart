import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';

const _badgeSize = Spacing.xl + Spacing.xxxs;

class const CountBadge({
  super.key,
  required final int _count,
  required final Color _color,
  required final Color _textColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: _badgeSize),
      height: _badgeSize,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxs),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Text(
        _count.toCountLabel(context),
        style: context.t.labelLarge?.copyWith(color: _textColor),
      ),
    );
  }
}
