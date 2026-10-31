import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _feedPageSize = 50;

@injectable
class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc(
    this._tagRepository,
    this._vocabularyRepository,
    this._textToSpeechRepository,
    this._externalLinkRepository,
    this._languageRepository,
    this._languageWordsRepository,
  ) : super(
        const CollectionLoading(
          setup: null,
          tag: null,
          practiceCount: null,
          tagWordCount: null,
          vocabularies: null,
          tags: null,
          feedLimit: 0,
          filter: emptyVocabularyFilter,
        ),
      ) {
    on<CollectionStarted>(_onStarted);
    on<CollectionLanguageChanged>(_onLanguageChanged, transformer: restartable());
    on<CollectionFeedEvent>(_onFeedEvent, transformer: restartable());
    on<CollectionRenamed>(_onRenamed);
    on<CollectionDeleteRequested>(_onDeleteRequested);
    on<CollectionVocabularySpeakRequested>(_onVocabularySpeakRequested);
    on<CollectionPhotographerLinkOpened>(_onPhotographerLinkOpened);
  }

  final TagRepository _tagRepository;
  final VocabularyRepository _vocabularyRepository;
  final TextToSpeechRepository _textToSpeechRepository;
  final ExternalLinkRepository _externalLinkRepository;
  final LanguageRepository _languageRepository;
  final LanguageWordsRepository _languageWordsRepository;
  String? _tagId;

  Future<void> _onStarted(CollectionStarted event, Emitter<CollectionState> emit) async {
    _tagId = event.tagId;
    await Future.wait([
      emit.forEach(
        _languageRepository.watchLanguageSetup(),
        onData: (result) {
          if (result case Success(data: final setup?)) {
            if (setup.selected != _setup?.selected) {
              add(CollectionLanguageChanged(language: setup.selected));
            }
            return _merged(setup: setup);
          }
          return state;
        },
      ),
      emit.forEach(
        _tagRepository.watchTag(event.tagId),
        onData: (result) => switch (result) {
          Success(data: final tag?) => _merged(tag: tag),
          Success(data: null) => const CollectionClosed(),
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

  Future<void> _onLanguageChanged(
    CollectionLanguageChanged event,
    Emitter<CollectionState> emit,
  ) async {
    final tagId = _tagId;
    if (tagId == null) return;
    add(CollectionFilterChanged(filter: _filter));
    await Future.wait([
      emit.forEach(
        _vocabularyRepository.watchVocabularyOverview(languages: {event.language}, tagId: tagId),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(
            practiceCount: data.practiceCountWith(_setup?.learnedOf(event.language)?.newWords),
          ),
          Failure(:final error) => CollectionFailure(error: error),
        },
      ),
      emit.forEach(
        _languageWordsRepository.watchLanguageCoverage(event.language),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(
            tagWordCount: data.collections
                .where((collection) => collection.tag.id == tagId)
                .fold<int>(0, (count, collection) => count + collection.totalCount),
          ),
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
    final language = _setup?.selected;
    if (tagId == null || feed == null || language == null) return;
    emit(_merged(filter: feed.filter));
    await emit.forEach(
      _vocabularyRepository.watchVocabularies(
        language: language,
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
    final language = _setup?.selected;
    final text = language == null ? null : event.vocabulary.textIn(language);
    if (language == null || text == null) return;
    _emitError(emit, null);
    final result = await _textToSpeechRepository.speak(text: text, language: language);
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  Future<void> _onPhotographerLinkOpened(
    CollectionPhotographerLinkOpened event,
    Emitter<CollectionState> emit,
  ) async {
    _emitError(emit, null);
    final result = await _externalLinkRepository.open(event.url);
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  LanguageSetup? get _setup => switch (state) {
    CollectionLoading(:final setup) => setup,
    CollectionLoaded(:final setup) => setup,
    CollectionClosed() || CollectionFailure() => null,
  };

  VocabularyFilter get _filter => switch (state) {
    CollectionLoading(:final filter) || CollectionLoaded(:final filter) => filter,
    CollectionClosed() || CollectionFailure() => emptyVocabularyFilter,
  };

  void _emitError(Emitter<CollectionState> emit, AppError? error) {
    if (state case final CollectionLoaded loaded) emit(loaded.copyWith(error: error));
  }

  CollectionState _merged({
    LanguageSetup? setup,
    Tag? tag,
    int? practiceCount,
    int? tagWordCount,
    List<Vocabulary>? vocabularies,
    List<Tag>? tags,
    int? feedLimit,
    VocabularyFilter? filter,
  }) {
    return switch (state) {
      final CollectionLoaded loaded => loaded.copyWith(
        setup: setup,
        tag: tag,
        practiceCount: practiceCount,
        tagWordCount: tagWordCount,
        vocabularies: vocabularies,
        tags: tags,
        feedLimit: feedLimit,
        filter: filter,
      ),
      final CollectionLoading loading => _completed(
        CollectionLoading(
          setup: setup ?? loading.setup,
          tag: tag ?? loading.tag,
          practiceCount: practiceCount ?? loading.practiceCount,
          tagWordCount: tagWordCount ?? loading.tagWordCount,
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
        setup: final setup?,
        tag: final tag?,
        practiceCount: final practiceCount?,
        tagWordCount: final tagWordCount?,
        vocabularies: final vocabularies?,
        tags: final tags?,
        :final feedLimit,
        :final filter,
      ) =>
        CollectionLoaded(
          setup: setup,
          tag: tag,
          practiceCount: practiceCount,
          tagWordCount: tagWordCount,
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
