import 'package:shared/domain/entities/vocabulary_level.dart';

extension VocabularyLevelValueExtensions on double {
  VocabularyLevel toVocabularyLevel() => VocabularyLevel.values.lastWhere(
    (level) => this >= level.floor,
    orElse: () => VocabularyLevel.novice,
  );
}
