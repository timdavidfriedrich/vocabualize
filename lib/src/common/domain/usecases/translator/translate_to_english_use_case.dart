import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

final translateToEnglishUseCaseProvider = Provider((ref) {
  return TranslateToEnglishUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
    translatorRepository: ref.watch(translatorRepositoryProvider),
  );
});

class TranslateToEnglishUseCase {
  final SettingsRepository _settingsRepository;
  final TranslatorRepository _translatorRepository;

  const TranslateToEnglishUseCase({
    required SettingsRepository settingsRepository,
    required TranslatorRepository translatorRepository,
  })  : _settingsRepository = settingsRepository,
        _translatorRepository = translatorRepository;

  Future<String> call(String source) async {
    final sourceLanguage = await _settingsRepository.getSourceLanguage();
    final usePremiumTranslator = await _settingsRepository.getUsePremiumTranslator();
    return _translatorRepository.translate(
      source: source,
      sourceLanguageId: sourceLanguage.translatorId,
      targetLanguageId: Language.english().translatorId,
      usePremiumTranslator: usePremiumTranslator,
    );
  }
}
