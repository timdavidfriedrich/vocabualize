import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';

const _activeBackgroundOpacity = 0.2;
const _inactiveBackgroundOpacity = 0.1;
const _mutedOpacity = 0.6;

class const StreakChip({
  super.key,
  required final Streak _streak,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isActive = _streak.isTodayActive;
    final mutedColor = context.c.onSurface.withValues(alpha: _mutedOpacity);
    return Tooltip(
      message: context.s.streakTitle(_streak.current),
      child: InkWell(
        onTap: _onPressed,
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxxs),
          decoration: BoxDecoration(
            color: isActive
                ? context.c.primary.withValues(alpha: _activeBackgroundOpacity)
                : context.c.onSurface.withValues(alpha: _inactiveBackgroundOpacity),
            borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
            border: isActive
                ? Border.all(color: context.c.primary, width: Spacing.borderWidthThin)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _streak.current.toCountLabel(context),
                style: context.t.labelMedium?.copyWith(
                  color: isActive ? context.c.onSurface : mutedColor,
                ),
              ),
              const SizedBox(width: Spacing.xxxs),
              Icon(
                Icons.local_fire_department_rounded,
                color: isActive ? context.c.primary : mutedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
