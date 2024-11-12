import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';

final initCloudNotificationsUseCaseProvider = AutoDisposeProvider((ref) {
  return InitCloudNotificationsUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
  );
});

class InitCloudNotificationsUseCase {
  final NotificationRepository _notificationRepository;

  const InitCloudNotificationsUseCase({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  void call() {
    _notificationRepository.initCloudNotifications();
  }
}
