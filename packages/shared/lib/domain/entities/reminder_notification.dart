import 'package:dart_mappable/dart_mappable.dart';

part 'reminder_notification.mapper.dart';

@MappableClass()
class const ReminderNotification({
  required final DateTime at,
  required final String title,
  required final String body,
  required final String channelName,
}) with ReminderNotificationMappable;
