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
const _iconTileSize = Spacing.xxxl - Spacing.xs;
const _rowGap = Spacing.borderWidthMedium;

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
          padding: EdgeInsets.fromLTRB(
            Spacing.l,
            0,
            Spacing.l,
            Spacing.xxl + MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StreakList(streak: streak),
              const SizedBox(height: Spacing.xl),
              _StreakCalendar(streak: streak),
            ],
          ),
        ),
        null => const SizedBox.shrink(),
      },
    );
  }
}

class const _StreakList({
  required final Streak _streak,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: _rowGap,
        children: [
          _StreakRow(
            icon: Icons.local_fire_department_rounded,
            isHighlighted: true,
            title: context.s.streakCurrentLabel,
            value: Text(context.s.streakDays(_streak.current), style: context.t.titleLarge),
          ),
          _StreakRow(
            icon: Icons.emoji_events_outlined,
            title: context.s.streakLongestLabel,
            value: Text(context.s.streakDays(_streak.longest), style: context.t.bodyLarge),
          ),
          _StreakRow(
            icon: Icons.ac_unit_rounded,
            title: context.s.streakFreezesLabel,
            value: Text(
              context.s.streakFreezesValue(_streak.freezes, _streak.maxFreezes),
              style: context.t.bodyLarge,
            ),
            details: context.s.streakFreezeExplanation(
              _streak.activeDaysPerFreeze,
              _streak.maxFreezes,
            ),
          ),
        ],
      ),
    );
  }
}

class const _StreakRow({
  required final IconData _icon,
  required final String _title,
  required final Widget _value,
  final String? _details,
  final bool _isHighlighted = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.c.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: _iconTileSize,
                  height: _iconTileSize,
                  decoration: BoxDecoration(
                    color: _isHighlighted ? context.c.primary : context.c.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(Spacing.radiusM),
                  ),
                  child: Icon(
                    _icon,
                    color: _isHighlighted ? context.c.onPrimary : context.c.primary,
                  ),
                ),
                const SizedBox(width: Spacing.m),
                Expanded(child: Text(_title, style: context.t.titleMedium)),
                const SizedBox(width: Spacing.s),
                _value,
              ],
            ),
            if (_details case final details?)
              Padding(
                padding: const EdgeInsets.only(left: _iconTileSize + Spacing.m, top: Spacing.xs),
                child: Text(details, style: context.t.bodyMedium),
              ),
          ],
        ),
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
      spacing: Spacing.xs,
      children: [
        Row(
          spacing: Spacing.xs,
          children: [
            for (var index = 0; index < _daysPerWeek; index++)
              Expanded(
                child: Center(
                  child: ExcludeSemantics(
                    child: Text(
                      localizations.narrowWeekdays[(firstWeekday + index) % _daysPerWeek],
                      style: context.t.labelMedium?.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
          ],
        ),
        for (var week = 0; week < _calendarWeeks; week++)
          Row(
            spacing: Spacing.xs,
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
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusM),
            color: switch ((isActive, isFrozen, isFuture)) {
              (true, _, _) => context.c.primary,
              (_, true, _) => context.c.primary.withValues(alpha: _frozenBackgroundOpacity),
              (_, _, true) => context.c.surfaceContainer,
              _ => context.c.surfaceContainerHigh,
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
                    style: switch ((isActive, isFuture)) {
                      (true, _) => context.t.labelLarge?.copyWith(color: context.c.onPrimary),
                      (_, true) => context.t.bodyMedium?.copyWith(color: context.c.outline),
                      _ => context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
