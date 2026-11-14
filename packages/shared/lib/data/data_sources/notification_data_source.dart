import 'dart:async';

import 'package:shared/data/models/local_reminder_kind.dart';
import 'package:shared/data/models/local_reminder_notification.dart';

abstract class NotificationDataSource {
  Stream<bool> watchIsPermitted();

  Future<bool> requestPermission();

  Future<void> replaceReminders(
    LocalReminderKind kind,
    List<LocalReminderNotification> reminders,
  );
}
