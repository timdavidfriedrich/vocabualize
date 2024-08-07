import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/constants/language_constants.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/free_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class TranslatorRepositoryImpl implements TranslatorRepository {
  final _freeTranslator = sl.get<FreeTranslatorDataSource>();
  final _premiumTranslator = sl.get<PremiumTranslatorDataSource>();

  @override
  Future<String> translateToEnglish(String source) async {
    return await translate(source, targetLanguageId: LanguageConstants.englishCode);
  }

  @override
  Future<String> translate(
    String source, {
    String? sourceLanguageId,
    String? targetLanguageId,
  }) async {
    final settings = Provider.of<SettingsProvider>(Global.context, listen: false);
    String sourceLanguage = sourceLanguageId ?? settings.sourceLanguage.translatorId;
    String targetLanguage = targetLanguageId ?? settings.targetLanguage.translatorId;
    if (settings.usePremiumTranslator) {
      return await _premiumTranslator.translate(
        source: source,
        sourceLang: sourceLanguage,
        targetLang: targetLanguage,
      );
    } else {
      return await _freeTranslator.translate(
        source: source,
        sourceLang: sourceLanguage,
        targetLang: targetLanguage,
      );
    }
  }
}
