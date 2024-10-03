import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final setAreImagesEnabledUseCaseProvider = Provider.family((ref, bool value) {
  return SetAreImagesEnabledUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(value);
});

class SetAreImagesEnabledUseCase {
  final SettingsRepository _settingsRepository;

  const SetAreImagesEnabledUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(bool value) => _settingsRepository.setAreImagesEnabled(value);
}
