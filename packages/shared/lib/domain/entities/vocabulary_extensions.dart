import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';

extension VocabularyExtensions on Vocabulary {
  Translation? get entered => translations.values
      .where((translation) => translation.origin == TranslationOrigin.entered)
      .firstOrNull;

  String? textIn(Language language) => translations[language]?.text;

  String promptIn(Language language) => textIn(language) ?? entered?.text ?? "";

  double levelIn(Language language) => progress[language]?.level ?? 0;
}
