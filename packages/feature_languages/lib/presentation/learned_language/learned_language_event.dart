import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

sealed class LearnedLanguageEvent {
  const LearnedLanguageEvent();
}

class const LearnedLanguageStarted({
  required final Language language,
}) extends LearnedLanguageEvent;

class const LearnedLanguageAskMeInChanged({
  required final Language? language,
}) extends LearnedLanguageEvent;

class const LearnedLanguageAskMeInLevelChanged({
  required final VocabularyLevel level,
}) extends LearnedLanguageEvent;

class const LearnedLanguageNewWordsChanged({
  required final NewWordLimit newWords,
}) extends LearnedLanguageEvent;

class const LearnedLanguagePauseRequested() extends LearnedLanguageEvent;

class const LearnedLanguageResumeRequested({
  required final bool startsOver,
}) extends LearnedLanguageEvent;

class const LearnedLanguageDeleteRequested() extends LearnedLanguageEvent;
