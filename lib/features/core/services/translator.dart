import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Translator {
  static final _translator = GoogleTranslator();

  static Future<String> translate(String source) async {
    Translation translation = await _translator.translate(
      source,
      from: Provider.of<SettingsProv>(Keys.context, listen: false).sourceLang,
      to: Provider.of<SettingsProv>(Keys.context, listen: false).targetLang,
    );
    return translation.toString();
  }
}
