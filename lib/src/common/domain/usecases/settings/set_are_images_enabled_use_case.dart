import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';

final setAreImagesEnabledUseCaseProvider = AutoDisposeFutureProvider.family((ref, bool value) {
  ref.onDispose(() {
    ref.invalidate(getAreImagesEnabledUseCaseProvider);
  });
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
