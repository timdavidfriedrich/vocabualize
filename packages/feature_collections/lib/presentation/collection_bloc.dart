import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
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
        ),
      ) {
    on<CollectionStarted>(_onStarted);
    on<CollectionFeedEndReached>(_onFeedEndReached, transformer: restartable());
    on<CollectionRenamed>(_onRenamed);
    on<CollectionDeleteRequested>(_onDeleteRequested);
    on<CollectionVocabularySpeakRequested>(_onVocabularySpeakRequested);
    on<CollectionVocabularyDeleteRequested>(_onVocabularyDeleteRequested);
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

  Future<void> _onFeedEndReached(
    CollectionFeedEndReached event,
    Emitter<CollectionState> emit,
  ) async {
    final tagId = _tagId;
    final limit = switch (state) {
      CollectionLoading(:final feedLimit) ||
      CollectionLoaded(:final feedLimit) => feedLimit + _feedPageSize,
      CollectionClosed() || CollectionFailure() => null,
    };
    if (tagId == null || limit == null) return;
    await emit.forEach(
      _vocabularyRepository.watchVocabularies(limit: limit, tagId: tagId),
      onData: (result) => switch (result) {
        Success(:final data) => _merged(vocabularies: data, feedLimit: limit),
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

  Future<void> _onVocabularyDeleteRequested(
    CollectionVocabularyDeleteRequested event,
    Emitter<CollectionState> emit,
  ) async {
    _emitError(emit, null);
    final result = await _vocabularyRepository.deleteVocabulary(event.vocabularyId);
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
  }) {
    return switch (state) {
      final CollectionLoaded loaded => loaded.copyWith(
        tag: tag,
        dueCount: dueCount,
        vocabularies: vocabularies,
        tags: tags,
        feedLimit: feedLimit,
      ),
      final CollectionLoading loading => _completed(
        CollectionLoading(
          tag: tag ?? loading.tag,
          dueCount: dueCount ?? loading.dueCount,
          vocabularies: vocabularies ?? loading.vocabularies,
          tags: tags ?? loading.tags,
          feedLimit: feedLimit ?? loading.feedLimit,
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
      ) =>
        CollectionLoaded(
          tag: tag,
          dueCount: dueCount,
          vocabularies: vocabularies,
          tags: tags,
          feedLimit: feedLimit,
          error: null,
        ),
      _ => loading,
    };
  }
}
