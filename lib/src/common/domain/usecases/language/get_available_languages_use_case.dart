import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/language_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getAvailableLanguagesUseCaseProvider = FutureProvider((ref) {
  return GetAvailableLanguagesUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
    languageRepository: ref.watch(languageRepositoryProvider),
  ).call();
});

class GetAvailableLanguagesUseCase {
  final LanguageRepository _languageRepository;
  final SettingsRepository _settingsRepository;

  const GetAvailableLanguagesUseCase({
    required LanguageRepository languageRepository,
    required SettingsRepository settingsRepository,
  })  : _languageRepository = languageRepository,
        _settingsRepository = settingsRepository;

  Future<List<Language>> call() async {
    final usePremiumTranslator = await _settingsRepository.getUsePremiumTranslator();
    return _languageRepository.getLangauges(usePremiumTranslator: usePremiumTranslator);
  }
}
