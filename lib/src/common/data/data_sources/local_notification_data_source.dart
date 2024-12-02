import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:log/log.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';

final localNotificationDataSourceProvider = Provider((ref) {
  return LocalNotificationDataSource();
});

class LocalNotificationDataSource {
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _practiseNotificationId = 1;
  final _gatherNotificationId = 2;

  Future<void> init() async {
    const androidInitializationSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
    const darwinInitializationSettings = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await _requestPermissions();
    await _initTimeZone();
    await _localNotifications.initialize(initializationSettings);
  }

  Future<void> _requestPermissions() async {
    try {
      if (await Permission.notification.isDenied) {
        final hasGranted = await Permission.notification.request().isGranted;
        Log.hint(
          "Notification permission has been ${hasGranted ? "granted" : "denied"}.",
        );
      }
      if (await Permission.scheduleExactAlarm.isDenied) {
        final hasGranted =
            await Permission.scheduleExactAlarm.request().isGranted;
        Log.hint(
          "Schedule exact alarm permission has been ${hasGranted ? "granted" : "denied"}.",
        );
      }
    } on PlatformException catch (e) {
      Log.error("Failed to request permissions", exception: e);
    }
  }

  Future<void> _initTimeZone() async {
    tz.initializeTimeZones();
    final locationName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }

  void schedulePractiseNotification({
    required TimeOfDay time,
    int? numberOfVocabularies,
  }) async {
    await _localNotifications.cancel(_practiseNotificationId);
    // * Notification will always be shown, currently, since we can't check due vocabularies rn
    // if (numberOfVocabularies == null || numberOfVocabularies <= 1) {
    //   Log.warning(
    //     "Not scheduling practise notification because there are no vocabularies to practise.",
    //   );
    //   return;
    // }
    await _scheduleLocalNotification(
      id: _practiseNotificationId,
      // TODO: Replace with arb
      title: "Let's practise 🎯",
      // TODO: Replace with arb
      body: "Some vocabularies are due. You'll rock this! :D",
      time: time,
    );
    Log.hint(
      "Schedule practise notification at $time with $numberOfVocabularies vocabularies.",
    );
  }

  void scheduleGatherNotification({
    required TimeOfDay time,
    required Language targetLanguage,
  }) async {
    await _localNotifications.cancel(_gatherNotificationId);
    await _scheduleLocalNotification(
      id: _gatherNotificationId,
      // TODO: Replace with arb
      title: "Look around you 👀",
      // TODO: Replace with arb
      body: "Which things don't you know in ${targetLanguage.name}?"
          "\nLet's add them to your collection!",
      time: time,
    );
    Log.hint(
      "Schedule gather notification at $time for ${targetLanguage.name}.",
    );
  }

  Future<void> _scheduleLocalNotification({
    required int id,
    required TimeOfDay time,
    String? title = CommonConstants.appName,
    String? body,
    String? payload,
  }) async {
    final now = DateTime.now();
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate.isBefore(now)
          ? scheduledDate.add(const Duration(days: 1))
          : scheduledDate,
      _getLocalNotificationDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // TODO: Is this in use?
  Future<void> showLocalNotification({
    int id = 0,
    String? title = CommonConstants.appName,
    String? body,
    String? payload,
  }) async {
    return await _localNotifications.show(
      id,
      title,
      body,
      _getLocalNotificationDetails(),
      payload: payload,
    );
  }

  NotificationDetails _getLocalNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_id",
        "channel_name",
        channelDescription: "channel_description",
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
