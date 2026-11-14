import 'dart:async';

abstract class CalendarDataSource {
  Stream<DateTime> watchToday();
}
