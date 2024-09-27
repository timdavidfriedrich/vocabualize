import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/data/data_sources/free_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/data/data_sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/text_to_speech_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

final languageRepositoryProvider = Provider((ref) {
  return LanguageRepositoryImpl(
    freeTranslatorDataSource: ref.watch(freeTranslatorDataSourceProvider),
    premiumTranslatorDataSource: ref.watch(premiumTranslatorDataSourceProvider),
    speechToTextDataSource: ref.watch(speechToTextDataSourceProvider),
    textToSpeechDataSource: ref.watch(textToSpeechDataSourceProvider),
  );
});

class LanguageRepositoryImpl implements LanguageRepository {
  final FreeTranslatorDataSource _freeTranslatorDataSource;
  final PremiumTranslatorDataSource _premiumTranslatorDataSource;
  final SpeechToTextDataSource _speechToTextDataSource;
  final TextToSpeechDataSource _textToSpeechDataSource;

  const LanguageRepositoryImpl({
    required FreeTranslatorDataSource freeTranslatorDataSource,
    required PremiumTranslatorDataSource premiumTranslatorDataSource,
    required SpeechToTextDataSource speechToTextDataSource,
    required TextToSpeechDataSource textToSpeechDataSource,
  })  : _freeTranslatorDataSource = freeTranslatorDataSource,
        _premiumTranslatorDataSource = premiumTranslatorDataSource,
        _speechToTextDataSource = speechToTextDataSource,
        _textToSpeechDataSource = textToSpeechDataSource;

  @override
  Future<Language?> findLanguage({String? translatorId, String? speechToTextId, String? textToSpeechId}) async {
    Language? result;
    List<Language> languages = await getLangauges();
    for (Language language in languages) {
      if (translatorId != null && language.translatorId.toLowerCase() != translatorId.toLowerCase()) continue;
      if (speechToTextId != null && language.translatorId.toLowerCase() != speechToTextId) continue;
      if (textToSpeechId != null && language.translatorId.toLowerCase() != textToSpeechId) continue;
      result = language;
    }
    return result;
  }

  // TODO ARCHITECTURE: Remove provider package and use settings data source maybe or something similar

  @override
  Future<List<Language>> getLangauges() async {
    List<Language> result = [];
    List<String> translatorIds = provider.Provider.of<SettingsProvider>(Global.context, listen: false).usePremiumTranslator
        ? _premiumTranslatorDataSource.translatorLanguages.keys.toList()
        : _freeTranslatorDataSource.translatorLanguages.keys.toList();
    Map<String, String> speechToTextMap = await _getSpeechToTextMap();
    List<String> textToSpeechIds = await _textToSpeechDataSource.getLanguages();
    for (String translatorId in translatorIds) {
      String speechToTextId = speechToTextMap.keys.toList().firstWhere(
            (id) => id.toLowerCase().startsWith(translatorId.toLowerCase()),
            orElse: () => "",
          );
      String textToSpeechId = textToSpeechIds.firstWhere(
        (id) => id.toLowerCase().startsWith(translatorId.toLowerCase()),
        orElse: () => "",
      );
      if (speechToTextId == "" || textToSpeechId == "") continue;
      result.add(
        Language(
            name: (speechToTextMap[speechToTextId] ?? "Unknown").split(" (").first,
            translatorId: translatorId,
            speechToTextId: speechToTextId,
            textToSpeechId: textToSpeechId),
      );
    }
    result.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return result;
  }

  Future<Map<String, String>> _getSpeechToTextMap() async {
    List<LocaleName> locales = await _speechToTextDataSource.getLocales();

    Map<String, String> result = {};
    for (LocaleName locale in locales) {
      result[locale.localeId] = locale.name;
    }
    return result;
  }
}
