import 'package:shared/domain/entities/activity_type.dart';

const _activityAdd = "add";
const _activityPractice = "practice";
const _dateDigits = 2;
const _yearDigits = 4;

extension ActivityTypeMappers on ActivityType {
  String get value => switch (this) {
    ActivityType.add => _activityAdd,
    ActivityType.practice => _activityPractice,
  };
}

extension LocalDateMappers on DateTime {
  // * a wall-clock date in the user's time zone, "yyyy-MM-dd", the format the legacy export wrote
  String toLocalDateString() {
    final local = toLocal();
    final year = "${local.year}".padLeft(_yearDigits, "0");
    final month = "${local.month}".padLeft(_dateDigits, "0");
    final day = "${local.day}".padLeft(_dateDigits, "0");
    return "$year-$month-$day";
  }
}
