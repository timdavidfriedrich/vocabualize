import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/notification_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/reminder_notification_mappers.dart';
import 'package:shared/domain/entities/reminder_notification.dart';
import 'package:shared/domain/repositories/reminder_repository.dart';

@Injectable(as: ReminderRepository)
class const ReminderRepositoryImpl(
  final NotificationDataSource _dataSource,
) implements ReminderRepository {
  @override
  Stream<AppResult<bool>> watchNotificationPermission() =>
      _dataSource.watchIsPermitted().toAppResult();

  @override
  Future<AppResult<bool>> requestNotificationPermission() async {
    try {
      return Success(await _dataSource.requestPermission());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> schedulePracticeReminders(List<ReminderNotification> reminders) async {
    try {
      await _dataSource.replacePracticeReminders([
        for (final reminder in reminders) reminder.toLocalReminderNotification(),
      ]);
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
