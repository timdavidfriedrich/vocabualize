import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

abstract class CalendarDataSource {
  Stream<DateTime> watchToday();
}

@Injectable(as: CalendarDataSource)
class const CalendarDataSourceImpl() implements CalendarDataSource {
  @override
  Stream<DateTime> watchToday() {
    Timer? midnightTimer;
    AppLifecycleListener? lifecycleListener;
    late final StreamController<DateTime> controller;
    void emitToday() {
      final now = DateTime.now();
      midnightTimer?.cancel();
      midnightTimer = Timer(DateTime(now.year, now.month, now.day + 1).difference(now), emitToday);
      if (!controller.isClosed) controller.add(DateTime(now.year, now.month, now.day));
    }

    controller = StreamController<DateTime>(
      onListen: () {
        lifecycleListener = AppLifecycleListener(onResume: emitToday);
        emitToday();
      },
      onCancel: () {
        midnightTimer?.cancel();
        lifecycleListener?.dispose();
      },
    );
    return controller.stream.distinct();
  }
}
