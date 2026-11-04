import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';

const _chipHeight = Spacing.xxxl - Spacing.xs;

class const StreakChip({
  super.key,
  required final Streak _streak,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.s.streakTitle(_streak.current),
      child: Material(
        color: context.c.primaryContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onPressed,
          child: Container(
            height: _chipHeight,
            constraints: const BoxConstraints(minWidth: _chipHeight),
            padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: Spacing.xxs,
              children: [
                Text(
                  _streak.current.toCountLabel(context),
                  style: context.t.titleMedium?.copyWith(
                    color: context.c.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_streak.isTodayActive)
                  Icon(
                    Icons.local_fire_department_outlined,
                    color: context.c.primary,
                    size: Spacing.iconS,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
