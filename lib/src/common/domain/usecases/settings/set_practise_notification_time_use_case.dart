import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_practise_notification_time_use_dart.dart';

final setPractiseNotificationTimeUseCaseProvider = AutoDisposeProvider.family((ref, TimeOfDay time) {
  ref.onDispose(() {
    ref.invalidate(getPractiseNotificationTimeUseCaseProvider);
  });
  return SetPractiseNotificationTimeUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(time);
});

class SetPractiseNotificationTimeUseCase {
  final SettingsRepository _settingsRepository;

  const SetPractiseNotificationTimeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(TimeOfDay time) => _settingsRepository.setPractiseNotificationTime(time);
}
