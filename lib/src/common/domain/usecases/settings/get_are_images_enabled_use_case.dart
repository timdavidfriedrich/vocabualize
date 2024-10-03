import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getAreImagesEnabledUseCaseProvider = Provider((ref) {
  return GetAreImagesEnabledUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class GetAreImagesEnabledUseCase {
  final SettingsRepository _settingsRepository;

  const GetAreImagesEnabledUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<bool> call() => _settingsRepository.getAreImagesEnabled();
}
