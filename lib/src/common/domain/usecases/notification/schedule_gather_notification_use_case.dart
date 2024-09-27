import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';

final scheduleGatherNotificationUseCaseProvider = Provider((ref) {
  return ScheduleGatherNotificationUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
  );
});

class ScheduleGatherNotificationUseCase {
  final NotificationRepository _notificationRepository;

  const ScheduleGatherNotificationUseCase({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  void call() {
    _notificationRepository.scheduleGatherNotification();
  }
}
