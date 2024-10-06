import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final setTargetLanguageUseCaseProvider = AutoDisposeProvider.family((ref, Language language) {
  return SetTargetLanguageUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(language);
});

class SetTargetLanguageUseCase {
  final SettingsRepository _settingsRepository;

  const SetTargetLanguageUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(Language language) => _settingsRepository.setTargetLanguage(language);
}
