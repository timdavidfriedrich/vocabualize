import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';

class ScheduleGatherNotificationUseCase {
  final _notificationRepository = sl.get<NotificationRepository>();

  void call() {
    _notificationRepository.scheduleGatherNotification();
  }
}
