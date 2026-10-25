import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _feedPageSize = 50;
const _recentMaxAge = Duration(days: 7);
const _recentLimit = 10;

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._vocabularyRepository, this._tagRepository, this._textToSpeechRepository)
    : super(
        const HomeLoading(
          overview: null,
          recentVocabularies: null,
          collections: null,
          vocabularies: null,
          feedLimit: 0,
        ),
      ) {
    on<HomeStarted>(_onStarted);
    on<HomeFeedEndReached>(_onFeedEndReached, transformer: restartable());
    on<HomeVocabularySpeakRequested>(_onVocabularySpeakRequested);
    on<HomeVocabularyDeleteRequested>(_onVocabularyDeleteRequested);
  }

  final VocabularyRepository _vocabularyRepository;
  final TagRepository _tagRepository;
  final TextToSpeechRepository _textToSpeechRepository;

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
    ]);
  }

  Future<void> _onFeedEndReached(HomeFeedEndReached event, Emitter<HomeState> emit) async {
    final limit = switch (state) {
      HomeLoading(:final feedLimit) || HomeLoaded(:final feedLimit) => feedLimit + _feedPageSize,
      HomeFailure() => null,
    };
    if (limit == null) return;
    await emit.forEach(
      _vocabularyRepository.watchVocabularies(limit: limit),
      onData: (result) => switch (result) {
        Success(:final data) => _merged(vocabularies: data, feedLimit: limit),
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
  }) {
    return switch (state) {
      final HomeLoaded loaded => loaded.copyWith(
        overview: overview,
        recentVocabularies: recentVocabularies,
        collections: collections,
        vocabularies: vocabularies,
        feedLimit: feedLimit,
      ),
      final HomeLoading loading => _completed(
        HomeLoading(
          overview: overview ?? loading.overview,
          recentVocabularies: recentVocabularies ?? loading.recentVocabularies,
          collections: collections ?? loading.collections,
          vocabularies: vocabularies ?? loading.vocabularies,
          feedLimit: feedLimit ?? loading.feedLimit,
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
      ) =>
        HomeLoaded(
          overview: overview,
          recentVocabularies: recentVocabularies,
          collections: collections,
          vocabularies: vocabularies,
          feedLimit: feedLimit,
          error: null,
        ),
      _ => loading,
    };
  }
}
