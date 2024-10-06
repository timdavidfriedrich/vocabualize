import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_gather_notification_time_use_case.dart';

final setGatherNotificationTimeUseCaseProvider = AutoDisposeProvider.family((ref, TimeOfDay time) {
  ref.onDispose(() {
    ref.invalidate(getGatherNotificationTimeUseCaseProvider);
  });
  return SetGatherNotificationTimeUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(time);
});

class SetGatherNotificationTimeUseCase {
  final SettingsRepository _settingsRepository;

  const SetGatherNotificationTimeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(TimeOfDay time) => _settingsRepository.setGatherNotificationTime(time);
}
