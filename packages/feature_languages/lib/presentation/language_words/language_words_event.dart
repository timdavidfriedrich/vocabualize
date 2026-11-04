import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:shared/domain/entities/language.dart';

sealed class LanguageWordsEvent {
  const LanguageWordsEvent();
}

class const LanguageWordsStarted({
  required final Language language,
  required final bool isAdding,
}) extends LanguageWordsEvent;

class const LanguageWordsOptionChanged({
  required final LanguageWordsOption option,
}) extends LanguageWordsEvent;

class const LanguageWordsCollectionToggled({
  required final String tagId,
}) extends LanguageWordsEvent;

class const LanguageWordsUntaggedToggled() extends LanguageWordsEvent;

class const LanguageWordsPreviewRequested() extends LanguageWordsEvent;

class const LanguageWordsSaveRequested() extends LanguageWordsEvent;
