import 'package:core/error/app_result.dart';
import 'package:feature_home/domain/repositories/article_repository.dart';
import 'package:feature_home/presentation/home/home_event.dart';
import 'package:feature_home/presentation/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._articleRepository) : super(const HomeLoading()) {
    on<HomeStarted>(_onStarted);
    on<HomeRefreshed>(_onRefreshed);
  }

  final ArticleRepository _articleRepository;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) => _load(emit);

  Future<void> _onRefreshed(HomeRefreshed event, Emitter<HomeState> emit) => _load(emit);

  Future<void> _load(Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    emit(switch (await _articleRepository.getArticles()) {
      Success(:final data) => HomeLoaded(articles: data),
      Failure(:final error) => HomeFailure(error: error),
    });
  }
}
