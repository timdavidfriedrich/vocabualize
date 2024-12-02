import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_gather_notification_time_use_case.dart';

final setGatherNotificationTimeUseCaseProvider = AutoDisposeProvider.family((ref, TimeOfDay time) {
  ref.onDispose(() {
    ref.invalidate(getGatherNotificationTimeUseCaseProvider);
  });
  return SetGatherNotificationTimeUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(time);
});

class SetGatherNotificationTimeUseCase {
  final NotificationRepository _notificationRepository;
  final SettingsRepository _settingsRepository;

  const SetGatherNotificationTimeUseCase({
    required NotificationRepository notificationRepository,
    required SettingsRepository settingsRepository,
  })  : _notificationRepository = notificationRepository,
        _settingsRepository = settingsRepository;

  Future<void> call(TimeOfDay time) {
    return _settingsRepository.setGatherNotificationTime(time).then((_) async {
      _notificationRepository.scheduleGatherNotification(
        time: time,
        targetLanguage: await _settingsRepository.getTargetLanguage(),
      );
    });
  }
}
