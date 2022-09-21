import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Translator {
  static final _translator = GoogleTranslator();

  static Future<String> inEnglish(String source) async {
    // TODO: Imlement a better, more independent way to filter
    List<String> articles = ["the", "a", "an", "der", "die", "das", "des", "ein", "eine"];
    String sourceFiltered = source;
    for (String article in articles) {
      if (source.startsWith("$article ")) sourceFiltered = source.replaceFirst(article, "");
    }
    Translation translation = await _translator.translate(
      sourceFiltered,
      from: Provider.of<SettingsProvider>(Keys.context, listen: false).sourceLang,
      to: "en",
    );
    return translation.toString();
  }

  static Future<String> translate(String source) async {
    Translation translation = await _translator.translate(
      source,
      from: Provider.of<SettingsProvider>(Keys.context, listen: false).sourceLang,
      to: Provider.of<SettingsProvider>(Keys.context, listen: false).targetLang,
    );
    return translation.toString();
  }
}
