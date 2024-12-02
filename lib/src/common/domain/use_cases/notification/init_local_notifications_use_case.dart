import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';

final initLocalNotificationsUseCaseProvider = AutoDisposeProvider((ref) {
  return InitLocalNotificationsUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
  );
});

class InitLocalNotificationsUseCase {
  final NotificationRepository _notificationRepository;

  const InitLocalNotificationsUseCase({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<void> call() {
    return _notificationRepository.initLocalNotifications();
  }
}
