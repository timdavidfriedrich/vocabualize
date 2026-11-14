import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

part 'language_setup.mapper.dart';

const _fewNewWords = 5;
const _defaultNewWordCount = 10;
const _manyNewWords = 20;

const defaultNewWordLimit = NewWordsUpTo(count: _defaultNewWordCount);
const defaultAskMeInFromLevel = VocabularyLevel.advanced;

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
