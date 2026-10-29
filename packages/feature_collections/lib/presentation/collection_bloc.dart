import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _feedPageSize = 50;

@injectable
class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc(this._tagRepository, this._vocabularyRepository, this._textToSpeechRepository)
    : super(
        const CollectionLoading(
          tag: null,
          dueCount: null,
          vocabularies: null,
          tags: null,
          feedLimit: 0,
          filter: emptyVocabularyFilter,
        ),
      ) {
    on<CollectionStarted>(_onStarted);
    on<CollectionFeedEvent>(_onFeedEvent, transformer: restartable());
    on<CollectionRenamed>(_onRenamed);
    on<CollectionDeleteRequested>(_onDeleteRequested);
    on<CollectionVocabularySpeakRequested>(_onVocabularySpeakRequested);
  }

  final TagRepository _tagRepository;
  final VocabularyRepository _vocabularyRepository;
  final TextToSpeechRepository _textToSpeechRepository;
  String? _tagId;

  Future<void> _onStarted(CollectionStarted event, Emitter<CollectionState> emit) async {
    _tagId = event.tagId;
    add(const CollectionFeedEndReached());
    await Future.wait([
      emit.forEach(
        _tagRepository.watchTag(event.tagId),
        onData: (result) => switch (result) {
          Success(data: final tag?) => _merged(tag: tag),
          Success(data: null) => const CollectionClosed(),
          Failure(:final error) => CollectionFailure(error: error),
        },
      ),
      emit.forEach(
        _vocabularyRepository.watchVocabularyOverview(tagId: event.tagId),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(dueCount: data.dueCount),
          Failure(:final error) => CollectionFailure(error: error),
        },
      ),
      emit.forEach(
        _tagRepository.watchTags(),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(tags: data),
          Failure(:final error) => CollectionFailure(error: error),
        },
      ),
    ]);
  }

  Future<void> _onFeedEvent(CollectionFeedEvent event, Emitter<CollectionState> emit) async {
    final tagId = _tagId;
    final feed = switch ((state, event)) {
      (CollectionClosed() || CollectionFailure(), _) => null,
      (
        CollectionLoading(:final feedLimit, :final filter) ||
            CollectionLoaded(:final feedLimit, :final filter),
        CollectionFeedEndReached(),
      ) =>
        (limit: feedLimit + _feedPageSize, filter: filter),
      (_, CollectionFilterChanged(:final filter)) => (limit: _feedPageSize, filter: filter),
    };
    if (tagId == null || feed == null) return;
    emit(_merged(filter: feed.filter));
    await emit.forEach(
      _vocabularyRepository.watchVocabularies(
        limit: feed.limit,
        tagId: tagId,
        filter: feed.filter,
      ),
      onData: (result) => switch (result) {
        Success(:final data) => _merged(vocabularies: data, feedLimit: feed.limit),
        Failure(:final error) => CollectionFailure(error: error),
      },
    );
  }

  Future<void> _onRenamed(CollectionRenamed event, Emitter<CollectionState> emit) async {
    if (state case final CollectionLoaded loaded) {
      _emitError(emit, null);
      final result = await _tagRepository.renameTag(loaded.tag, name: event.name.trim());
      if (result case Failure(:final error)) _emitError(emit, error);
    }
  }

  Future<void> _onDeleteRequested(
    CollectionDeleteRequested event,
    Emitter<CollectionState> emit,
  ) async {
    if (state case final CollectionLoaded loaded) {
      _emitError(emit, null);
      final result = await _tagRepository.deleteTag(loaded.tag.id);
      if (result case Failure(:final error)) _emitError(emit, error);
    }
  }

  Future<void> _onVocabularySpeakRequested(
    CollectionVocabularySpeakRequested event,
    Emitter<CollectionState> emit,
  ) async {
    _emitError(emit, null);
    final result = await _textToSpeechRepository.speak(
      text: event.vocabulary.target,
      language: event.vocabulary.targetLanguage,
    );
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  void _emitError(Emitter<CollectionState> emit, AppError? error) {
    if (state case final CollectionLoaded loaded) emit(loaded.copyWith(error: error));
  }

  CollectionState _merged({
    Tag? tag,
    int? dueCount,
    List<Vocabulary>? vocabularies,
    List<Tag>? tags,
    int? feedLimit,
    VocabularyFilter? filter,
  }) {
    return switch (state) {
      final CollectionLoaded loaded => loaded.copyWith(
        tag: tag,
        dueCount: dueCount,
        vocabularies: vocabularies,
        tags: tags,
        feedLimit: feedLimit,
        filter: filter,
      ),
      final CollectionLoading loading => _completed(
        CollectionLoading(
          tag: tag ?? loading.tag,
          dueCount: dueCount ?? loading.dueCount,
          vocabularies: vocabularies ?? loading.vocabularies,
          tags: tags ?? loading.tags,
          feedLimit: feedLimit ?? loading.feedLimit,
          filter: filter ?? loading.filter,
        ),
      ),
      final CollectionClosed closed => closed,
      final CollectionFailure failure => failure,
    };
  }

  CollectionState _completed(CollectionLoading loading) {
    return switch (loading) {
      CollectionLoading(
        tag: final tag?,
        dueCount: final dueCount?,
        vocabularies: final vocabularies?,
        tags: final tags?,
        :final feedLimit,
        :final filter,
      ) =>
        CollectionLoaded(
          tag: tag,
          dueCount: dueCount,
          vocabularies: vocabularies,
          tags: tags,
          feedLimit: feedLimit,
          filter: filter,
          error: null,
        ),
      _ => loading,
    };
  }
}
