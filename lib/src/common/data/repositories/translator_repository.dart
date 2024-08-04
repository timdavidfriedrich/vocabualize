import 'package:provider/provider.dart';
import 'package:translator_plus/translator_plus.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/src/common/data/models/deepl_request.dart';
import 'package:vocabualize/src/common/data/models/deepl_response.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

// TODO ARCHITECTURE: It's a repo, but some deeper things should be moved other files like mappers and data sources (e.g. google translator)
class TranslatorRepository {
  static final _googleTranslator = GoogleTranslator();
  static final _deeplTranslator = PremiumTranslatorDataSource();

  static Future<String> translateToEnglish(String source, {bool filtered = false}) async {
    List<String> articles = ["the", "a", "an"];
    String result = await translate(source, targetLanguageId: "en");
    if (filtered) {
      for (String article in articles) {
        if (result.toString().startsWith("$article ")) {
          result = result.toString().replaceFirst("$article ", "");
        }
      }
    }
    return result;
  }

  static Future<String> translate(String source, {String? sourceLanguageId, String? targetLanguageId}) async {
    String sourceLanguage = sourceLanguageId ?? Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage.translatorId;
    String targetLanguage = targetLanguageId ?? Provider.of<SettingsProvider>(Global.context, listen: false).targetLanguage.translatorId;
    if (Provider.of<SettingsProvider>(Global.context, listen: false).useDeepL) {
      DeepLResponse? deepLResponse = await _deeplTranslator.translate(DeepLRequest(
        text: source,
        sourceLang: sourceLanguage,
        targetLang: targetLanguage,
      ));
      return deepLResponse?.translation ?? "";
    } else {
      Translation translation = await _googleTranslator.translate(
        source,
        from: sourceLanguage,
        to: targetLanguage,
      );
      return translation.toString();
    }
  }
}
