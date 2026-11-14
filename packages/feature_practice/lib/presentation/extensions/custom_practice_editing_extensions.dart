import 'dart:math';

import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';
import 'package:shared/domain/entities/practice_session.dart';

extension CustomPracticeEditingExtensions on CustomPracticeEditing {
  List<Language> get activeLanguages => [for (final learned in setup.active) learned.language];

  List<Language> get shownEnabledLanguages => [
    for (final language in activeLanguages)
      if (enabledLanguages.contains(language)) language,
  ];

  bool includesAllWords(Language language) => allWordsLanguages.contains(language);

  int availableReviewCountOf(Language language) => switch (counts?[language]) {
    final counts? => includesAllWords(language) ? counts.startedCount : counts.dueCount,
    null => 0,
  };

  int reviewCountOf(Language language) {
    final available = availableReviewCountOf(language);
    return min(reviewWordCounts[language] ?? available, available);
  }

  int waitingCountOf(Language language) => counts?[language]?.waitingCount ?? 0;

  int newCountOf(Language language) {
    final waiting = waitingCountOf(language);
    final chosen =
        newWordCounts[language] ??
        switch (setup.learnedOf(language)?.newWords) {
          NewWordsUpTo(:final count) => count,
          AllNewWords() || null => waiting,
        };
    return min(chosen, waiting);
  }

  int get totalCount => shownEnabledLanguages.fold(
    0,
    (sum, language) => sum + reviewCountOf(language) + newCountOf(language),
  );

  CustomPracticePlan get plan => CustomPracticePlan(
    languages: [
      for (final language in shownEnabledLanguages)
        CustomPracticeLanguagePlan(
          language: language,
          words: includesAllWords(language) ? PracticeWords.all : PracticeWords.due,
          reviewWordCount: reviewCountOf(language),
          newWordCount: newCountOf(language),
        ),
    ],
    tagIds: tagIds,
  );
}
