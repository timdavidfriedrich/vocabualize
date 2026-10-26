import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/local_reminder_kind.dart';
import 'package:shared/data/models/local_reminder_notification.dart';
import 'package:timezone/data/latest_10y.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

const _icon = "ic_notification";
const _notificationIdsPerKind = 1000;

abstract class NotificationDataSource {
  Stream<bool> watchIsPermitted();

  Future<bool> requestPermission();

  Future<void> replaceReminders(
    LocalReminderKind kind,
    List<LocalReminderNotification> reminders,
  );
}

@LazySingleton(as: NotificationDataSource)
class NotificationDataSourceImpl() implements NotificationDataSource {
  final _plugin = FlutterLocalNotificationsPlugin();
  Future<void>? _initialization;

  @override
  Stream<bool> watchIsPermitted() {
    AppLifecycleListener? lifecycleListener;
    late final StreamController<bool> controller;
    Future<void> emitCurrent() async {
      final isPermitted = await _isPermitted();
      if (!controller.isClosed) controller.add(isPermitted);
    }

    controller = StreamController<bool>(
      onListen: () {
        lifecycleListener = AppLifecycleListener(onResume: () => unawaited(emitCurrent()));
        unawaited(emitCurrent());
      },
      onCancel: () => lifecycleListener?.dispose(),
    );
    return controller.stream.distinct();
  }

  @override
  Future<bool> requestPermission() async {
    await _initialize();
    return await _android?.requestNotificationsPermission() ?? false;
  }

  @override
  Future<void> replaceReminders(
    LocalReminderKind kind,
    List<LocalReminderNotification> reminders,
  ) async {
    await _initialize();
    final firstId = kind.firstNotificationId;
    for (final pending in await _plugin.pendingNotificationRequests()) {
      if (pending.id >= firstId && pending.id < firstId + _notificationIdsPerKind) {
        await _plugin.cancel(id: pending.id);
      }
    }
    for (final (index, reminder) in reminders.take(_notificationIdsPerKind).indexed) {
      await _plugin.zonedSchedule(
        id: firstId + index,
        title: reminder.title,
        body: reminder.body,
        scheduledDate: timezone.TZDateTime.from(reminder.at, timezone.local),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            kind.channelId,
            reminder.channelName,
            icon: _icon,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  AndroidFlutterLocalNotificationsPlugin? get _android =>
      _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  Future<bool> _isPermitted() async {
    await _initialize();
    return await _android?.areNotificationsEnabled() ?? false;
  }

  Future<void> _initialize() => _initialization ??= _initializeOnce();

  Future<void> _initializeOnce() async {
    timezone_data.initializeTimeZones();
    final localTimezone = await FlutterTimezone.getLocalTimezone();
    timezone.setLocalLocation(timezone.getLocation(localTimezone.identifier));
    await _plugin.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings(_icon)),
    );
  }
}
