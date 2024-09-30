import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final areImagesEnabledUseCaseProvider = FutureProvider((ref) {
  return AreImagesEnabledUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class AreImagesEnabledUseCase {
  final SettingsRepository _settingsRepository;

  const AreImagesEnabledUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<bool> call() => _settingsRepository.getAreImagesEnabled();
}
