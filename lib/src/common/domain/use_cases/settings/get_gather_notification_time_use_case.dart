import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getGatherNotificationTimeUseCaseProvider = AutoDisposeProvider((ref) {
  return GetGatherNotificationTimeUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class GetGatherNotificationTimeUseCase {
  final SettingsRepository _settingsRepository;

  const GetGatherNotificationTimeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<TimeOfDay> call() => _settingsRepository.getGatherNotificationTime();
}
