import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension VocabularyLabelExtensions on Vocabulary {
  String titleIn(BuildContext context, Language language) =>
      textIn(language) ?? context.s.vocabularyTranslationPendingLabel;

  VocabularyLevel levelOf(Language language) => levelIn(language).toVocabularyLevel();
}
