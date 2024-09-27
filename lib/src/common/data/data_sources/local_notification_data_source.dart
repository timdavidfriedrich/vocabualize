import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart' as provider;
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

final localNotificationDataSourceProvider = Provider((ref) => LocalNotificationDataSource());

// TODO ARCHITUCTURE: Remove Provider package and pass default values and settings to the methods

class LocalNotificationDataSource {
  static const TimeOfDay _defaultScheduleTime = TimeOfDay(hour: 13, minute: 0);
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  void init() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();
    const LinuxInitializationSettings linuxInitializationSettings = LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
      macOS: darwinInitializationSettings,
      linux: linuxInitializationSettings,
    );

    if (Platform.isAndroid) {
      _requestAndroidPermissions();
    }

    await _localNotifications.initialize(initializationSettings);

    await _initTimeZone();
  }

  void _requestAndroidPermissions() async {
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
      Log.warning("Notification permissions got rejected.");
      return;
    }
  }

  Future<void> _initTimeZone() async {
    tz.initializeTimeZones();
    final locationName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }

  void schedulePractiseNotification({int? numberOfVocabularies, TimeOfDay? timeOfDay}) async {
    await _localNotifications.cancel(1);
    if (numberOfVocabularies == null || numberOfVocabularies <= 1) {
      Log.warning("Not scheduling practise notification because there are no vocabularies to practise.");
      return;
    }
    _scheduleLocalNotification(
      id: 1,
      // TODO: Replace with arb
      title: "Let's practise 🎯",
      // TODO: Replace with arb
      body: "$numberOfVocabularies words are due. You'll rock this! :D",
      time: timeOfDay ?? provider.Provider.of<SettingsProvider>(Global.context, listen: false).practiseNotificationTime,
    );
  }

  void scheduleGatherNotification() async {
    await _localNotifications.cancel(2);
    final Language targetLanguage = provider.Provider.of<SettingsProvider>(Global.context, listen: false).targetLanguage;
    _scheduleLocalNotification(
      id: 2,
      // TODO: Replace with arb
      title: "Look around you 👀",
      // TODO: Replace with arb
      body: "Which things don't you know in ${targetLanguage.name}?\nLet's add them to your collection!",
      time: provider.Provider.of<SettingsProvider>(Global.context, listen: false).gatherNotificationTime,
    );
  }

  // TODO: Is this in use?
  Future<void> showLocalNotification({int id = 0, String? title = CommonConstants.appName, String? body, String? payload}) async {
    return await _localNotifications.show(id, title, body, await _getLocalNotificationDetails(), payload: payload);
  }

  Future<void> _scheduleLocalNotification({
    int id = 0,
    String? title = CommonConstants.appName,
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
