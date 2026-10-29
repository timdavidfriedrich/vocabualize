import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';

part 'collection_state.mapper.dart';

@MappableClass()
sealed class CollectionState with CollectionStateMappable {
  const CollectionState();
}

@MappableClass()
class const CollectionLoading({
  required final Tag? tag,
  required final int? dueCount,
  required final List<Vocabulary>? vocabularies,
  required final List<Tag>? tags,
  required final int feedLimit,
  required final VocabularyFilter filter,
}) extends CollectionState with CollectionLoadingMappable;

@MappableClass()
class const CollectionLoaded({
  required final Tag tag,
  required final int dueCount,
  required final List<Vocabulary> vocabularies,
  required final List<Tag> tags,
  required final int feedLimit,
  required final VocabularyFilter filter,
  required final AppError? error,
}) extends CollectionState with CollectionLoadedMappable;

@MappableClass()
class const CollectionClosed() extends CollectionState with CollectionClosedMappable;

@MappableClass()
class const CollectionFailure({
  required final AppError error,
}) extends CollectionState with CollectionFailureMappable;
