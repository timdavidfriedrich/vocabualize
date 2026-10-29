import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
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
  ) : super(
        const HomeLoading(
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
    on<HomeFeedEvent>(_onFeedEvent, transformer: restartable());
    on<HomeVocabularySpeakRequested>(_onVocabularySpeakRequested);
    on<HomeVocabularyDeleteRequested>(_onVocabularyDeleteRequested);
  }

  final VocabularyRepository _vocabularyRepository;
  final TagRepository _tagRepository;
  final TextToSpeechRepository _textToSpeechRepository;
  final WatchStreakUseCase _watchStreak;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    add(const HomeFeedEndReached());
    await Future.wait([
      emit.forEach(
        _vocabularyRepository.watchVocabularyOverview(),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(overview: data),
          Failure(:final error) => HomeFailure(error: error),
        },
      ),
      emit.forEach(
        _vocabularyRepository.watchRecentVocabularies(maxAge: _recentMaxAge, limit: _recentLimit),
        onData: (result) => switch (result) {
          Success(:final data) => _merged(recentVocabularies: data),
          Failure(:final error) => HomeFailure(error: error),
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

  Future<void> _onFeedEvent(HomeFeedEvent event, Emitter<HomeState> emit) async {
    final feed = switch ((state, event)) {
      (HomeFailure(), _) => null,
      (HomeLoading(:final feedLimit, :final filter) || HomeLoaded(:final feedLimit, :final filter),
          HomeFeedEndReached()) =>
        (limit: feedLimit + _feedPageSize, filter: filter),
      (_, HomeFilterChanged(:final filter)) => (limit: _feedPageSize, filter: filter),
    };
    if (feed == null) return;
    emit(_merged(filter: feed.filter));
    await emit.forEach(
      _vocabularyRepository.watchVocabularies(limit: feed.limit, filter: feed.filter),
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
    _emitError(emit, null);
    final result = await _textToSpeechRepository.speak(
      text: event.vocabulary.target,
      language: event.vocabulary.targetLanguage,
    );
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  Future<void> _onVocabularyDeleteRequested(
    HomeVocabularyDeleteRequested event,
    Emitter<HomeState> emit,
  ) async {
    _emitError(emit, null);
    final result = await _vocabularyRepository.deleteVocabulary(event.vocabularyId);
    if (result case Failure(:final error)) _emitError(emit, error);
  }

  void _emitError(Emitter<HomeState> emit, AppError? error) {
    if (state case final HomeLoaded loaded) emit(loaded.copyWith(error: error));
  }

  HomeState _merged({
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
        overview: final overview?,
        recentVocabularies: final recentVocabularies?,
        collections: final collections?,
        vocabularies: final vocabularies?,
        :final feedLimit,
        :final filter,
        :final streak,
      ) =>
        HomeLoaded(
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
