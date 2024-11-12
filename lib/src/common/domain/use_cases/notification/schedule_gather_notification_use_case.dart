import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final scheduleGatherNotificationUseCaseProvider = AutoDisposeProvider((ref) {
  return ScheduleGatherNotificationUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  );
});

class ScheduleGatherNotificationUseCase {
  final NotificationRepository _notificationRepository;
  final SettingsRepository _settingsRepository;

  const ScheduleGatherNotificationUseCase({
    required NotificationRepository notificationRepository,
    required SettingsRepository settingsRepository,
  })  : _notificationRepository = notificationRepository,
        _settingsRepository = settingsRepository;

  Future<void> call() async {
    final time = await _settingsRepository.getGatherNotificationTime();
    final targetLanguage = await _settingsRepository.getTargetLanguage();
    _notificationRepository.scheduleGatherNotification(
      time: time,
      targetLanguage: targetLanguage,
    );
  }
}
