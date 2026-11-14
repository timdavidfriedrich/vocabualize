import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_extensions.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_extensions.dart';

extension LanguageSetupExtensions on LanguageSetup {
  List<LearnedLanguage> get active => [
    for (final learnedLanguage in learned)
      if (!learnedLanguage.isPaused) learnedLanguage,
  ];

  List<LearnedLanguage> get paused => [
    for (final learnedLanguage in learned)
      if (learnedLanguage.isPaused) learnedLanguage,
  ];

  LearnedLanguage? learnedOf(Language language) =>
      learned.where((learnedLanguage) => learnedLanguage.language == language).firstOrNull;

  bool isLearning(Language language) => learnedOf(language) != null;

  List<Language> get writingLanguages => {
    main,
    for (final learnedLanguage in active) learnedLanguage.language,
    for (final learnedLanguage in active) ?learnedLanguage.askMeIn,
  }.toList();

  Language? promptFor(Vocabulary vocabulary, Language language) {
    final candidates = [
      if (learnedOf(language) case LearnedLanguage(:final askMeIn?, :final askMeInFromLevel)
          when switch (learnedOf(askMeIn)) {
            null => vocabulary.levelIn(language) >= askMeInFromLevel.floor,
            LearnedLanguage() => vocabulary.levelIn(askMeIn) >= askMeInFromLevel.floor,
          })
        askMeIn,
      main,
      ?vocabulary.entered?.language,
    ];
    return candidates
        .where(
          (candidate) =>
              !candidate.isSameLanguageAs(language) && vocabulary.textIn(candidate) != null,
        )
        .firstOrNull;
  }
}

extension LearnedLanguageDefaultExtensions on Language {
  LearnedLanguage toLearnedLanguage() {
    return LearnedLanguage(
      language: this,
      askMeIn: null,
      askMeInFromLevel: defaultAskMeInFromLevel,
      newWords: defaultNewWordLimit,
      isPaused: false,
    );
  }
}
