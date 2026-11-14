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
