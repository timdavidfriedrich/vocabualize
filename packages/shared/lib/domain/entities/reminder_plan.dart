import 'package:dart_mappable/dart_mappable.dart';

part 'reminder_plan.mapper.dart';

// * times are null while their source could not be read, so those reminders stay as scheduled
@MappableClass()
class const ReminderPlan({
  required final bool isPermitted,
  required final List<DateTime>? practiceTimes,
  required final List<DateTime>? streakTimes,
  required final int streakCount,
}) with ReminderPlanMappable;
