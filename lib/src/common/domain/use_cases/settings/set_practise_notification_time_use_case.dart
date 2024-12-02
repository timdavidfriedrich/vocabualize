import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_practise_notification_time_use_dart.dart';

final setPractiseNotificationTimeUseCaseProvider =
    AutoDisposeProvider.family((ref, TimeOfDay time) {
  ref.onDispose(() {
    ref.invalidate(getPractiseNotificationTimeUseCaseProvider);
  });
  return SetPractiseNotificationTimeUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(time);
});

class SetPractiseNotificationTimeUseCase {
  final NotificationRepository _notificationRepository;
  final SettingsRepository _settingsRepository;

  const SetPractiseNotificationTimeUseCase({
    required NotificationRepository notificationRepository,
    required SettingsRepository settingsRepository,
  })  : _notificationRepository = notificationRepository,
        _settingsRepository = settingsRepository;

  Future<void> call(TimeOfDay time) {
    return _settingsRepository.setPractiseNotificationTime(time).then(
      (_) async {
        _notificationRepository.schedulePractiseNotification(time: time);
      },
    );
  }
}
