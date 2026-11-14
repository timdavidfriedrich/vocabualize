import 'package:shared/domain/entities/streak.dart';

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
