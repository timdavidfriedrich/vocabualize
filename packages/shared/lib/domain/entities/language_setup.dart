import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

part 'language_setup.mapper.dart';

const _fewNewWords = 5;
const _defaultNewWordCount = 10;
const _manyNewWords = 20;

const defaultNewWordLimit = NewWordsUpTo(count: _defaultNewWordCount);

const newWordLimits = [
  NewWordsUpTo(count: _fewNewWords),
  NewWordsUpTo(count: _defaultNewWordCount),
  NewWordsUpTo(count: _manyNewWords),
  AllNewWords(),
];

@MappableClass()
class const LanguageSetup({
  required final Language main,
  required final List<LearnedLanguage> learned,
  required final Language selected,
}) with LanguageSetupMappable;

@MappableClass()
class const LearnedLanguage({
  required final Language language,
  required final Language? askMeIn,
  required final VocabularyLevel askMeInFromLevel,
  required final NewWordLimit newWords,
  required final bool isPaused,
}) with LearnedLanguageMappable;

@MappableClass()
sealed class NewWordLimit with NewWordLimitMappable {
  const NewWordLimit();
}

@MappableClass()
class const NewWordsUpTo({
  required final int count,
}) extends NewWordLimit with NewWordsUpToMappable;

@MappableClass()
class const AllNewWords() extends NewWordLimit with AllNewWordsMappable;

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

  Language? promptFor(Vocabulary vocabulary, Language language) {
    final candidates = [
      if (learnedOf(language) case LearnedLanguage(:final askMeIn?, :final askMeInFromLevel)
          when switch (learnedOf(askMeIn)) {
            null => true,
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

extension LearnedLanguageDefaults on Language {
  LearnedLanguage toLearnedLanguage() {
    return LearnedLanguage(
      language: this,
      askMeIn: null,
      askMeInFromLevel: VocabularyLevel.advanced,
      newWords: defaultNewWordLimit,
      isPaused: false,
    );
  }
}
