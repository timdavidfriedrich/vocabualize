import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';

sealed class CollectionEvent {
  const CollectionEvent();
}

class const CollectionStarted({
  required final String tagId,
}) extends CollectionEvent;

sealed class CollectionFeedEvent extends CollectionEvent {
  const CollectionFeedEvent();
}

class const CollectionFeedEndReached() extends CollectionFeedEvent;

class const CollectionFilterChanged({
  required final VocabularyFilter filter,
}) extends CollectionFeedEvent;

class const CollectionRenamed({
  required final String name,
}) extends CollectionEvent;

class const CollectionDeleteRequested() extends CollectionEvent;

class const CollectionPhotographerLinkOpened({
  required final String url,
}) extends CollectionEvent;

class const CollectionVocabularySpeakRequested({
  required final Vocabulary vocabulary,
}) extends CollectionEvent;
