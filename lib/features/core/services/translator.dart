import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/features/core/services/deepl_api/deepl_request.dart';
import 'package:vocabualize/features/core/services/deepl_api/deepl_response.dart';
import 'package:vocabualize/features/core/services/deepl_api/deepl_service.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Translator {
  static final _googleTranslator = GoogleTranslator();
  static final _deeplTranslator = DeepLService();

  static Future<String> inEnglish(String source, {bool filtered = false}) async {
    List<String> articles = ["the", "a", "an"];
    Translation translation = await _googleTranslator.translate(
      source,
      from: Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage.translatorId,
      to: "en",
    );
    String result = translation.toString();
    if (filtered) {
      for (String article in articles) {
        if (translation.toString().startsWith("$article ")) {
          result = translation.toString().replaceFirst("$article ", "");
        }
      }
    }
    return result;
  }

  static Future<String> translate(String source) async {
    String sourceLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage.translatorId;
    String targetLanguage = Provider.of<SettingsProvider>(Global.context, listen: false).targetLanguage.translatorId;
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
