import 'package:shared/domain/entities/vocabulary.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class const HomeStarted() extends HomeEvent;

class const HomeFeedEndReached() extends HomeEvent;

class const HomeVocabularySpeakRequested({
  required final Vocabulary vocabulary,
}) extends HomeEvent;

class const HomeVocabularyDeleteRequested({
  required final String vocabularyId,
}) extends HomeEvent;
