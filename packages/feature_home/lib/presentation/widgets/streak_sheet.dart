import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/date_time_extensions.dart';

const _calendarWeeks = 4;
const _daysPerWeek = 7;
const _frozenBackgroundOpacity = 0.2;
const _mutedOpacity = 0.6;

Future<void> showStreakSheet(BuildContext context) {
  final bloc = context.read<HomeBloc>();
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(value: bloc, child: const _StreakSheet()),
  );
}

class const _StreakSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Streak?>(
      selector: (state) => switch (state) {
        HomeLoading(:final streak) || HomeLoaded(:final streak) => streak,
        HomeFailure() => null,
      },
      builder: (context, streak) => switch (streak) {
        final streak? => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Spacing.xl, 0, Spacing.xl, Spacing.xxl),
          child: _StreakDetails(streak: streak),
        ),
        null => const SizedBox.shrink(),
      },
    );
  }
}

class const _StreakDetails({
  required final Streak _streak,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              size: Spacing.iconXl,
              color: context.c.primary,
            ),
            const SizedBox(width: Spacing.s),
            Expanded(
              child: Text(context.s.streakTitle(_streak.current), style: context.t.headlineSmall),
            ),
          ],
        ),
        const SizedBox(height: Spacing.xs),
        Text(switch (_streak) {
          Streak(current: 0) => context.s.streakStartMessage,
          Streak(isTodayActive: true) => context.s.streakDoneMessage,
          Streak() => context.s.streakPendingMessage,
        }, style: context.t.bodyMedium),
        const SizedBox(height: Spacing.xl),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _StatTile(
                  label: context.s.streakLongestLabel,
                  child: Text(context.s.streakDays(_streak.longest), style: context.t.titleMedium),
                ),
              ),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: _StatTile(
                  label: context.s.streakFreezesLabel,
                  child: Semantics(
                    label: context.s.streakFreezesValue(_streak.freezes, _streak.maxFreezes),
                    child: ExcludeSemantics(
                      child: Row(
                        children: [
                          for (var index = 0; index < _streak.maxFreezes; index++)
                            Icon(
                              Icons.ac_unit_rounded,
                              color: index < _streak.freezes
                                  ? context.c.primary
                                  : context.c.onSurface.withValues(alpha: _mutedOpacity),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.xl),
        _StreakCalendar(streak: _streak),
        const SizedBox(height: Spacing.l),
        Text(
          context.s.streakFreezeExplanation(_streak.activeDaysPerFreeze, _streak.maxFreezes),
          style: context.t.bodySmall?.copyWith(color: context.c.outline),
        ),
      ],
    );
  }
}

class const _StatTile({
  required final String _label,
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_label, style: context.t.bodySmall?.copyWith(color: context.c.outline)),
          const SizedBox(height: Spacing.xxxs),
          _child,
        ],
      ),
    );
  }
}

class const _StreakCalendar({
  required final Streak _streak,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final firstWeekday = localizations.firstDayOfWeekIndex;
    final today = _streak.today;
    final daysIntoWeek = (today.weekday % _daysPerWeek - firstWeekday) % _daysPerWeek;
    final firstDay = DateTime(
      today.year,
      today.month,
      today.day - daysIntoWeek - (_calendarWeeks - 1) * _daysPerWeek,
    );
    return Column(
      children: [
        Row(
          children: [
            for (var index = 0; index < _daysPerWeek; index++)
              Expanded(
                child: Center(
                  child: ExcludeSemantics(
                    child: Text(
                      localizations.narrowWeekdays[(firstWeekday + index) % _daysPerWeek],
                      style: context.t.labelSmall?.copyWith(color: context.c.outline),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: Spacing.xs),
        for (var week = 0; week < _calendarWeeks; week++)
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.xxxs),
            child: Row(
              children: [
                for (var weekday = 0; weekday < _daysPerWeek; weekday++)
                  Expanded(
                    child: _CalendarDay(
                      streak: _streak,
                      day: DateTime(
                        firstDay.year,
                        firstDay.month,
                        firstDay.day + week * _daysPerWeek + weekday,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class const _CalendarDay({
  required final Streak _streak,
  required final DateTime _day,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = _streak.today;
    final isToday = DateUtils.isSameDay(_day, today);
    final isActive = _streak.activeDays.contains(_day);
    final isFrozen = _streak.frozenDays.contains(_day);
    final isFuture = _day.isAfter(today);
    final status = switch ((isActive, isFrozen, isToday, isFuture)) {
      (true, _, _, _) => context.s.streakDayActive,
      (_, true, _, _) => context.s.streakDayFrozen,
      (_, _, true, _) => context.s.streakDayPending,
      (_, _, _, true) => null,
      _ => context.s.streakDayMissed,
    };
    return Semantics(
      label: [_day.toWeekdayDateLabel(context), ?status].join(", "),
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xxxs),
        child: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: switch ((isActive, isFrozen)) {
                (true, _) => context.c.primary,
                (_, true) => context.c.primary.withValues(alpha: _frozenBackgroundOpacity),
                _ => null,
              },
              border: isToday && !isActive
                  ? Border.all(color: context.c.primary, width: Spacing.borderWidthMedium)
                  : null,
            ),
            child: Center(
              child: isFrozen
                  ? Icon(Icons.ac_unit_rounded, size: Spacing.iconS, color: context.c.primary)
                  : Text(
                      _day.toDayOfMonthLabel(context),
                      style: context.t.labelMedium?.copyWith(
                        color: switch ((isActive, isFuture)) {
                          (true, _) => context.c.onPrimary,
                          (_, true) => context.c.outline,
                          _ => context.c.onSurface.withValues(alpha: _mutedOpacity),
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
