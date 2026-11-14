import 'package:dart_mappable/dart_mappable.dart';

part 'local_reminder_notification.mapper.dart';

@MappableClass()
class const LocalReminderNotification({
  required final DateTime at,
  required final String title,
  required final String body,
  required final String channelName,
}) with LocalReminderNotificationMappable;
