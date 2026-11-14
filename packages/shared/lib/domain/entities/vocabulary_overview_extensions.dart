import 'dart:math';

import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';

extension VocabularyOverviewExtensions on VocabularyOverview {
  int practiceCountWith(NewWordLimit? limit) =>
      dueCount +
      switch (limit) {
        NewWordsUpTo(:final count) => min(waitingCount, count),
        AllNewWords() || null => waitingCount,
      };

  int countOf(VocabularyLevel level) => switch (level) {
    VocabularyLevel.novice => noviceCount,
    VocabularyLevel.beginner => beginnerCount,
    VocabularyLevel.advanced => advancedCount,
    VocabularyLevel.expert => expertCount,
  };
}
