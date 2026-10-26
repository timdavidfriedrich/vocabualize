import 'dart:math';

import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/activity_history.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/repositories/activity_repository.dart';

const _activeDaysPerFreeze = 7;
const _maxFreezes = 2;

@injectable
class const WatchStreakUseCase(
  final ActivityRepository _activityRepository,
) {
  Stream<AppResult<Streak>> call() {
    return _activityRepository.watchActivityHistory().map(
      (result) => switch (result) {
        Success(:final data) => Success(_streakOf(data)),
        Failure(:final error) => Failure(error),
      },
    );
  }

  Streak _streakOf(ActivityHistory history) {
    final today = history.today;
    final activeDays = {
      for (final day in history.activeDays)
        if (!day.isAfter(today)) day,
    };
    final frozenDays = <DateTime>{};
    var current = 0;
    var longest = 0;
    var freezes = 0;
    var activeRun = 0;
    void countActiveDay() {
      current++;
      activeRun++;
      if (activeRun == _activeDaysPerFreeze) {
        freezes = min(freezes + 1, _maxFreezes);
        activeRun = 0;
      }
      longest = max(longest, current);
    }

    if (activeDays.isNotEmpty) {
      final firstDay = activeDays.reduce(
        (earliest, day) => day.isBefore(earliest) ? day : earliest,
      );
      for (
        var day = firstDay;
        day.isBefore(today);
        day = DateTime(day.year, day.month, day.day + 1)
      ) {
        if (activeDays.contains(day)) {
          countActiveDay();
        } else if (current > 0 && freezes > 0) {
          freezes--;
          activeRun = 0;
          frozenDays.add(day);
        } else {
          current = 0;
          activeRun = 0;
        }
      }
    }
    final isTodayActive = activeDays.contains(today);
    if (isTodayActive) countActiveDay();
    return Streak(
      current: current,
      longest: longest,
      freezes: freezes,
      maxFreezes: _maxFreezes,
      activeDaysPerFreeze: _activeDaysPerFreeze,
      isTodayActive: isTodayActive,
      today: today,
      activeDays: activeDays,
      frozenDays: frozenDays,
    );
  }
}
