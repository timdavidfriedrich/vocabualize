import 'package:log/log.dart';

class DateParser {
  DateParser._();

  static DateTime? parseOrNull(String? date) {
    if (date == null) return null;
    try {
      return DateTime.parse(date);
    } on FormatException catch (e) {
      Log.error(
        "Failed to parse date: '$date'.",
        exception: e,
      );
      return null;
    }
  }
}
