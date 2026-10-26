import 'package:dart_mappable/dart_mappable.dart';

part 'streak.mapper.dart';

@MappableClass()
class const Streak({
  required final int current,
  required final int longest,
  required final int freezes,
  required final int maxFreezes,
  required final int activeDaysPerFreeze,
  required final bool isTodayActive,
  required final DateTime today,
  required final Set<DateTime> activeDays,
  required final Set<DateTime> frozenDays,
}) with StreakMappable;

extension StreakExtensions on Streak {
  List<DateTime> get daysAtRisk {
    if (current == 0) return const [];
    final firstDay = isTodayActive ? 1 : 0;
    return [
      for (var offset = firstDay; offset <= firstDay + freezes; offset++)
        DateTime(today.year, today.month, today.day + offset),
    ];
  }
}
