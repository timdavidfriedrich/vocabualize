import 'package:core/error/app_result.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _feedPageSize = 50;

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._vocabularyRepository) : super(const HomeLoading()) {
    on<HomeStarted>(_onStarted);
  }

  final VocabularyRepository _vocabularyRepository;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    await Future.wait([
      emit.forEach(
        _vocabularyRepository.watchVocabularies(limit: _feedPageSize),
        onData: (result) => switch (result) {
          Success(:final data) => _loaded.copyWith(vocabularies: data),
          Failure(:final error) => HomeFailure(error: error),
        },
      ),
      emit.forEach(
        _vocabularyRepository.watchVocabularyCount(),
        onData: (result) => switch (result) {
          Success(:final data) => _loaded.copyWith(vocabularyCount: data),
          Failure(:final error) => HomeFailure(error: error),
        },
      ),
    ]);
  }

  HomeLoaded get _loaded => switch (state) {
    final HomeLoaded loaded => loaded,
    _ => const HomeLoaded(vocabularies: [], vocabularyCount: 0),
  };
}
