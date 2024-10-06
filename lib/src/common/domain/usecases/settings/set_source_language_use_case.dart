import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final setSourceLanguageUseCaseProvider = AutoDisposeFutureProvider.family((ref, Language language) {
  return SetSourceLanguageUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(language);
});

class SetSourceLanguageUseCase {
  final SettingsRepository _settingsRepository;

  const SetSourceLanguageUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(Language language) => _settingsRepository.setSourceLanguage(language);
}
