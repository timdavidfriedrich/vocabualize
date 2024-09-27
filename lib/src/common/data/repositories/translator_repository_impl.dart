import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/constants/language_constants.dart';
import 'package:vocabualize/src/common/data/data_sources/free_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

final translatorRepositoryProvider = Provider((ref) {
  return TranslatorRepositoryImpl(
    freeTranslatorDataSource: ref.watch(freeTranslatorDataSourceProvider),
    premiumTranslatorDataSource: ref.watch(premiumTranslatorDataSourceProvider),
  );
});

class TranslatorRepositoryImpl implements TranslatorRepository {
  final FreeTranslatorDataSource _freeTranslatorDataSource;
  final PremiumTranslatorDataSource _premiumTranslatorDataSource;

  const TranslatorRepositoryImpl({
    required FreeTranslatorDataSource freeTranslatorDataSource,
    required PremiumTranslatorDataSource premiumTranslatorDataSource,
  })  : _freeTranslatorDataSource = freeTranslatorDataSource,
        _premiumTranslatorDataSource = premiumTranslatorDataSource;

  @override
  Future<String> translateToEnglish(String source) async {
    return await translate(source, targetLanguageId: LanguageConstants.englishCode);
  }

  // TODO ARCHITECTURE: Remove provider package and maybe use settings data source or something similar

  @override
  Future<String> translate(
    String source, {
    String? sourceLanguageId,
    String? targetLanguageId,
  }) async {
    final settings = provider.Provider.of<SettingsProvider>(Global.context, listen: false);
    String sourceLanguage = sourceLanguageId ?? settings.sourceLanguage.translatorId;
    String targetLanguage = targetLanguageId ?? settings.targetLanguage.translatorId;
    if (settings.usePremiumTranslator) {
      return await _premiumTranslatorDataSource.translate(
        source: source,
        sourceLang: sourceLanguage,
        targetLang: targetLanguage,
      );
    } else {
      return await _freeTranslatorDataSource.translate(
        source: source,
        sourceLang: sourceLanguage,
        targetLang: targetLanguage,
      );
    }
  }
}
