import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Translator {
  static final _translator = GoogleTranslator();

  static Future<String> inEnglish(String source, {bool filtered = false}) async {
    List<String> articles = ["the", "a", "an"];
    Translation translation = await _translator.translate(
      source,
      from: Provider.of<SettingsProvider>(Keys.context, listen: false).sourceLanguage.translatorId,
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
    Translation translation = await _translator.translate(
      source,
      from: Provider.of<SettingsProvider>(Keys.context, listen: false).sourceLanguage.translatorId,
      to: Provider.of<SettingsProvider>(Keys.context, listen: false).targetLanguage.translatorId,
    );
    return translation.toString();
  }
}
