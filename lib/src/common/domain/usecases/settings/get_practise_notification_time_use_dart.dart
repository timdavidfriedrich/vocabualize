import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getPractiseNotificationTimeUseCaseProvider = Provider((ref) {
  return GetPractiseNotificationTimeUseDart(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class GetPractiseNotificationTimeUseDart {
  final SettingsRepository _settingsRepository;

  const GetPractiseNotificationTimeUseDart({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<TimeOfDay> call() => _settingsRepository.getPractiseNotificationTime();
}
