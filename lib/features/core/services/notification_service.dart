import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService();
  static NotificationService get instance => _instance;

  static const TimeOfDay _defaultScheduleTime = TimeOfDay(hour: 13, minute: 0);
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  void init() {
    initCloudNotifications();
    initLocalNotifications(initScheduled: true);
  }

  void initCloudNotifications() {
    FirebaseMessaging.onBackgroundMessage(cloudNotificationBackgroundHandler);
  }

  void initLocalNotifications({bool initScheduled = false}) async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();
    const LinuxInitializationSettings linuxInitializationSettings = LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
      macOS: darwinInitializationSettings,
      linux: linuxInitializationSettings,
    );

    // * Request permission on Android
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      bool allowedExactAlarms = true;
      bool allowedNotifications = true;

      if (androidInfo.version.sdkInt >= 34) {
        allowedExactAlarms = await _localNotifications
                .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
                ?.requestExactAlarmsPermission() ??
            false;
      }
      if (androidInfo.version.sdkInt >= 33) {
        allowedNotifications = await _localNotifications
                .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission() ??
            false;
      }

      if (!allowedExactAlarms || !allowedNotifications) {
        Log.error("Notifications are not allowed.");
        return;
      }
    }

    await _localNotifications.initialize(initializationSettings);

    if (initScheduled) {
      await _initTimeZone();
      scheduleNotifications();
    }
  }

  void scheduleNotifications() {
    _schedulePractiseNotification();
    _scheduleGatherNotification();
  }

  Future<void> _initTimeZone() async {
    tz.initializeTimeZones();
    final locationName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }

  void _schedulePractiseNotification() async {
    await _localNotifications.cancel(1);
    final int vocabulariesToPractise = Provider.of<VocabularyProvider>(Global.context, listen: false).allToPractise.length;
    if (vocabulariesToPractise <= 1) return;
    scheduleLocalNotification(
      id: 1,
      // TODO: Replace with arb
      title: "Let's practise 🎯",
      // TODO: Replace with arb
      body: "$vocabulariesToPractise words are due. You'll rock this! :D",
      time: Provider.of<SettingsProvider>(Global.context, listen: false).practiseNotificationTime,
    );
  }

  void _scheduleGatherNotification() async {
    await _localNotifications.cancel(2);
    final Language targetLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).targetLanguage;
    scheduleLocalNotification(
      id: 2,
      // TODO: Replace with arb
      title: "Look around you 👀",
      // TODO: Replace with arb
      body: "Which things don't you know in ${targetLanguage.name}?\nLet's add them to your collection!",
      time: Provider.of<SettingsProvider>(Global.context, listen: false).gatherNotificationTime,
    );
  }

  Future<void> showLocalNotification({int id = 0, String? title = "Vocabualize", String? body, String? payload}) async {
    return await _localNotifications.show(id, title, body, await _getLocalNotificationDetails(), payload: payload);
  }

  Future<void> scheduleLocalNotification({
    int id = 0,
    String? title = "Vocabualize",
    String? body,
    String? payload,
    TimeOfDay time = _defaultScheduleTime,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
    return await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate.isBefore(now) ? scheduledDate.add(const Duration(days: 1)) : scheduledDate,
      await _getLocalNotificationDetails(),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<NotificationDetails> _getLocalNotificationDetails() async {
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

// * Must be top-level (outside of any class)
Future<void> cloudNotificationBackgroundHandler(RemoteMessage message) async {
  Log.hint(
    "Received a background message with id=${message.messageId}."
    "\n\tdata: ${message.data}"
    "\n\tnotification: ${message.notification ?? "-"}",
  );
}
