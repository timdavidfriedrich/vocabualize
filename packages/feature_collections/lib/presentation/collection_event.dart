import 'package:shared/domain/entities/vocabulary.dart';

sealed class CollectionEvent {
  const CollectionEvent();
}

class const CollectionStarted({
  required final String tagId,
}) extends CollectionEvent;

class const CollectionFeedEndReached() extends CollectionEvent;

class const CollectionRenamed({
  required final String name,
}) extends CollectionEvent;

class const CollectionDeleteRequested() extends CollectionEvent;

class const CollectionVocabularySpeakRequested({
  required final Vocabulary vocabulary,
}) extends CollectionEvent;

class const CollectionVocabularyDeleteRequested({
  required final String vocabularyId,
}) extends CollectionEvent;
