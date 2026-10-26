import 'package:dart_mappable/dart_mappable.dart';

part 'local_practice_reminder_setting.mapper.dart';

@MappableClass()
class const LocalPracticeReminderSetting({
  required final bool isEnabled,
  required final int hour,
  required final int minute,
}) with LocalPracticeReminderSettingMappable;
