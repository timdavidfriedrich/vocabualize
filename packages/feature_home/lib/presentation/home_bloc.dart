import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:shared/domain/use_cases/watch_streak_use_case.dart';

const _feedPageSize = 50;
const _recentMaxAge = Duration(days: 7);
const _recentLimit = 10;

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._vocabularyRepository,
    this._tagRepository,
    this._textToSpeechRepository,
    this._watchStreak,
    this._externalLinkRepository,
    this._languageRepository,
  ) : super(
        const HomeLoading(
          setup: null,
          overview: null,
          recentVocabularies: null,
          collections: null,
          vocabularies: null,
          feedLimit: 0,
          filter: emptyVocabularyFilter,
          streak: null,
        ),
      ) {
    on<HomeStarted>(_onStarted);
    on<HomeLanguageChanged>(_onLanguageChanged, transformer: restartable());
    on<HomeFeedEvent>(_onFeedEvent, transformer: restartable());
    on<HomeVocabularySpeakRequested>(_onVocabularySpeakRequested);
    on<HomePhotographerLinkOpened>(_onPhotographerLinkOpened);
  }

  final VocabularyRepository _vocabularyRepository;
  final TagRepository _tagRepository;
  final TextToSpeechRepository _textToSpeechRepository;
  final WatchStreakUseCase _watchStreak;
  final ExternalLinkRepository _externalLinkRepository;
  final LanguageRepository _languageRepository;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    await Future.wait([
      emit.forEach(
        _languageRepository.watchLanguageSetup(),
        onData: (result) {
          if (result case Success(data: final setup?)) {
            if (setup.selected != _setup?.selected) {
              add(HomeLanguageChanged(language: setup.selected));
            }
            return _merged(setup: setup);
          }
          return state;
        },
      ),
      emit.forEach(
        _tagRepository.watchCollectionPreviews(),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(collections: data),
          Failure(:final error) => HomeFailure(error: error),
        },
      ),
      emit.forEach(
        _watchStreak(),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(streak: data),
          Failure() => state,
        },
      ),
    ]);
  }

  Future<void> _onLanguageChanged(HomeLanguageChanged event, Emitter<HomeState> emit) async {
    final language = event.language;
    add(HomeFilterChanged(filter: _filter));
    await Future.wait([
      emit.forEach(
        _vocabularyRepository.watchVocabularyOverview(languages: {language}),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(overview: data),
          Failure(:final error) => HomeFailure(error: error),
        },
      ),
      emit.forEach(
        _vocabularyRepository.watchRecentVocabularies(
          language: language,
          maxAge: _recentMaxAge,
          limit: _recentLimit,
        ),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(recentVocabularies: data),
          Failure(:final error) => HomeFailure(error: error),
        },
      ),
    ]);
  }

  Future<void> _onFeedEvent(HomeFeedEvent event, Emitter<HomeState> emit) async {
    final feed = switch ((state, event)) {
      (HomeFailure(), _) => null,
      (
        HomeLoading(:final feedLimit, :final filter) || HomeLoaded(:final feedLimit, :final filter),
        HomeFeedEndReached(),
      ) =>
        (limit: feedLimit + _feedPageSize, filter: filter),
      (_, HomeFilterChanged(:final filter)) => (limit: _feedPageSize, filter: filter),
    };
    final language = _setup?.selected;
    if (feed == null || language == null) return;
    emit(_merged(filter: feed.filter));
    await emit.forEach(
      _vocabularyRepository.watchVocabularies(
        language: language,
        limit: feed.limit,
        filter: feed.filter,
      ),
      onData: (result) => switch (result) {
        Success(:final data) => _merged(vocabularies: data, feedLimit: feed.limit),
        Failure(:final error) => HomeFailure(error: error),
      },
    );
  }

  Future<void> _onVocabularySpeakRequested(
    HomeVocabularySpeakRequested event,
    Emitter<HomeState> emit,
  ) async {
    final language = _setup?.selected;
    final text = language == null ? null : event.vocabulary.textIn(language);
    if (language == null || text == null) return;
    _emitError(emit, null);
    final result = await _textToSpeechRepository.speak(text: text, language: language);
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  Future<void> _onPhotographerLinkOpened(
    HomePhotographerLinkOpened event,
    Emitter<HomeState> emit,
  ) async {
    _emitError(emit, null);
    final result = await _externalLinkRepository.open(event.url);
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  LanguageSetup? get _setup => switch (state) {
    HomeLoading(:final setup) => setup,
    HomeLoaded(:final setup) => setup,
    HomeFailure() => null,
  };

  VocabularyFilter get _filter => switch (state) {
    HomeLoading(:final filter) || HomeLoaded(:final filter) => filter,
    HomeFailure() => emptyVocabularyFilter,
  };

  void _emitError(Emitter<HomeState> emit, AppError? error) {
    if (state case final HomeLoaded loaded) emit(loaded.copyWith(error: error));
  }

  HomeState _merged({
    LanguageSetup? setup,
    VocabularyOverview? overview,
    List<Vocabulary>? recentVocabularies,
    List<CollectionPreview>? collections,
    List<Vocabulary>? vocabularies,
    int? feedLimit,
    VocabularyFilter? filter,
    Streak? streak,
  }) {
    return switch (state) {
      final HomeLoaded loaded => loaded.copyWith(
        setup: setup,
        overview: overview,
        recentVocabularies: recentVocabularies,
        collections: collections,
        vocabularies: vocabularies,
        feedLimit: feedLimit,
        filter: filter,
        streak: streak ?? loaded.streak,
      ),
      final HomeLoading loading => _completed(
        HomeLoading(
          setup: setup ?? loading.setup,
          overview: overview ?? loading.overview,
          recentVocabularies: recentVocabularies ?? loading.recentVocabularies,
          collections: collections ?? loading.collections,
          vocabularies: vocabularies ?? loading.vocabularies,
          feedLimit: feedLimit ?? loading.feedLimit,
          filter: filter ?? loading.filter,
          streak: streak ?? loading.streak,
        ),
      ),
      final HomeFailure failure => failure,
    };
  }

  HomeState _completed(HomeLoading loading) {
    return switch (loading) {
      HomeLoading(
        setup: final setup?,
        overview: final overview?,
        recentVocabularies: final recentVocabularies?,
        collections: final collections?,
        vocabularies: final vocabularies?,
        :final feedLimit,
        :final filter,
        :final streak,
      ) =>
        HomeLoaded(
          setup: setup,
          overview: overview,
          recentVocabularies: recentVocabularies,
          collections: collections,
          vocabularies: vocabularies,
          feedLimit: feedLimit,
          filter: filter,
          streak: streak,
          error: null,
        ),
      _ => loading,
    };
  }
}
