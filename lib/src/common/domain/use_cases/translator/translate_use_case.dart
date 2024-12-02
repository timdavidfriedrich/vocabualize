import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

final translateUseCaseProvider = AutoDisposeProvider((ref) {
  return TranslateUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
    translatorRepository: ref.watch(translatorRepositoryProvider),
  );
});

class TranslateUseCase {
  final SettingsRepository _settingsRepository;
  final TranslatorRepository _translatorRepository;

  const TranslateUseCase({
    required SettingsRepository settingsRepository,
    required TranslatorRepository translatorRepository,
  })  : _settingsRepository = settingsRepository,
        _translatorRepository = translatorRepository;

  Future<String> call(String source, {Language? sourceLanguage, Language? targetLanguage}) async {
    final usePremiumTranslator = await _settingsRepository.getUsePremiumTranslator();
    final safeSourceLanguage = sourceLanguage ?? await _settingsRepository.getSourceLanguage();
    final safeTargetLanguage = targetLanguage ?? await _settingsRepository.getTargetLanguage();
    return _translatorRepository.translate(
      source: source,
      sourceLanguageId: safeSourceLanguage.translatorId,
      targetLanguageId: safeTargetLanguage.translatorId,
      usePremiumTranslator: usePremiumTranslator,
    );
  }
}
