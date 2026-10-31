import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'vocabulary.mapper.dart';

@MappableClass()
class const Vocabulary({
  required final String id,
  required final Map<Language, Translation> translations,
  required final Map<Language, Progress> progress,
  required final VocabularyImage image,
  required final Set<String> tagIds,
  required final DateTime createdAt,
}) with VocabularyMappable;

extension VocabularyExtensions on Vocabulary {
  Translation? get entered => translations.values
      .where((translation) => translation.origin == TranslationOrigin.entered)
      .firstOrNull;

  String? textIn(Language language) => translations[language]?.text;

  String promptIn(Language language) => textIn(language) ?? entered?.text ?? "";

  double levelIn(Language language) => progress[language]?.level ?? 0;
}
