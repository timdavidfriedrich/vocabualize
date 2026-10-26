import 'package:dart_mappable/dart_mappable.dart';

part 'local_daily_reminder_setting.mapper.dart';

@MappableClass()
class const LocalDailyReminderSetting({
  required final bool isEnabled,
  required final int hour,
  required final int minute,
}) with LocalDailyReminderSettingMappable;
