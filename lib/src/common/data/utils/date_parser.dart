import 'package:log/log.dart';

class DateParser {
  DateParser._();

  static DateTime? parseOrNull(String? date) {
    if (date == null) return null;
    try {
      return DateTime.parse(date);
    } on FormatException catch (e) {
      Log.warning(
        "Failed to parse date: '$date'. Message: ${e.message}",
      );
      return null;
    }
  }
}
