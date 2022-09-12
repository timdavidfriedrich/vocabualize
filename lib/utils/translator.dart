import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/utils/providers/lang_provider.dart';

class Translator {
  static final _translator = GoogleTranslator();

  static Future<String> translate(String source) async {
    Translation translation = await _translator.translate(
      source,
      from: Provider.of<LangProv>(Keys.context, listen: false).sourceLang,
      to: Provider.of<LangProv>(Keys.context, listen: false).targetLang,
    );
    return translation.toString();
  }
}
