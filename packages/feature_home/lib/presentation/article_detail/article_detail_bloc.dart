import 'package:core/error/app_result.dart';
import 'package:feature_home/domain/repositories/article_repository.dart';
import 'package:feature_home/presentation/article_detail/article_detail_event.dart';
import 'package:feature_home/presentation/article_detail/article_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._articleRepository, @factoryParam this._articleId)
    : super(const ArticleDetailLoading()) {
    on<ArticleDetailStarted>(_onStarted);
  }

  final ArticleRepository _articleRepository;
  final String _articleId;

  Future<void> _onStarted(ArticleDetailStarted event, Emitter<ArticleDetailState> emit) async {
    emit(switch (await _articleRepository.getArticle(_articleId)) {
      Success(:final data) => ArticleDetailLoaded(article: data),
      Failure(:final error) => ArticleDetailFailure(error: error),
    });
  }
}
