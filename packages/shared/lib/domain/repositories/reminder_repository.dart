import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/reminder_notification.dart';

abstract class ReminderRepository {
  Stream<AppResult<bool>> watchNotificationPermission();

  Future<AppResult<bool>> requestNotificationPermission();

  Future<AppResult<()>> schedulePracticeReminders(List<ReminderNotification> reminders);
}
