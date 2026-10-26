import 'package:shared/data/models/local_reminder_notification.dart';
import 'package:shared/domain/entities/reminder_notification.dart';

extension ReminderNotificationMappers on ReminderNotification {
  LocalReminderNotification toLocalReminderNotification() {
    return LocalReminderNotification(at: at, title: title, body: body, channelName: channelName);
  }
}
