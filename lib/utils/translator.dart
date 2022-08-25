import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:vocabualize/utils/providers/lang_provider.dart';

class Translator {
  static final _translator = GoogleTranslator();

  static Future<String> translate(BuildContext context, String source) async {
    Translation translation = await _translator.translate(
      source,
      from: Provider.of<LangProv>(context, listen: false).getSourceLang(),
      to: Provider.of<LangProv>(context, listen: false).getTargetLang(),
    );
    return translation.toString();
  }
}
