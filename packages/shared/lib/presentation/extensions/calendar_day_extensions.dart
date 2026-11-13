import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

// * for calendar days (local year, month and day without a time), never for instants
extension CalendarDayExtensions on DateTime {
  String toDayOfMonthLabel(BuildContext context) => DateFormat.d(context.localeTag).format(this);

  String toWeekdayDateLabel(BuildContext context) =>
      DateFormat.MMMEd(context.localeTag).format(this);
}
