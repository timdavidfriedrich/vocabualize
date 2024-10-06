import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final setGatherNotificationTimeUseCaseProvider = AutoDisposeProvider.family((ref, TimeOfDay time) {
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
