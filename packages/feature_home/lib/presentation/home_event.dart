import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class const HomeStarted() extends HomeEvent;

sealed class HomeFeedEvent extends HomeEvent {
  const HomeFeedEvent();
}

class const HomeFeedEndReached() extends HomeFeedEvent;

class const HomeFilterChanged({
  required final VocabularyFilter filter,
}) extends HomeFeedEvent;

class const HomePhotographerLinkOpened({
  required final String url,
}) extends HomeEvent;

class const HomeVocabularySpeakRequested({
  required final Vocabulary vocabulary,
}) extends HomeEvent;
