import 'package:shared/domain/entities/activity_history.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _dateDigits = 2;
const _yearDigits = 4;

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

extension LocalDateStringMappers on String {
  DateTime? toLocalDate() => switch (DateTime.tryParse(this)) {
    final DateTime parsed => DateTime(parsed.year, parsed.month, parsed.day),
    null => null,
  };
}

extension LocalActivitiesMappers on List<LocalActivity> {
  ActivityHistory toActivityHistory({required DateTime today}) => ActivityHistory(
    activeDays: {for (final activity in this) ?activity.localDate.toLocalDate()},
    today: today,
  );
}
