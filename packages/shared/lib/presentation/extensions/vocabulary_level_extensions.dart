import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension VocabularyLevelExtensions on VocabularyLevel {
  Color toColor(BuildContext context) => switch (this) {
    VocabularyLevel.novice => context.levels.novice,
    VocabularyLevel.beginner => context.levels.beginner,
    VocabularyLevel.advanced => context.levels.advanced,
    VocabularyLevel.expert => context.levels.expert,
  };

  String toLabel(BuildContext context) => switch (this) {
    VocabularyLevel.novice => context.s.vocabularyLevelNovice,
    VocabularyLevel.beginner => context.s.vocabularyLevelBeginner,
    VocabularyLevel.advanced => context.s.vocabularyLevelAdvanced,
    VocabularyLevel.expert => context.s.vocabularyLevelExpert,
  };
}
