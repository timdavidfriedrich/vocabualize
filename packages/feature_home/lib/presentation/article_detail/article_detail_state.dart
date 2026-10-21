import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/article.dart';

sealed class ArticleDetailState {
  const ArticleDetailState();
}

class const ArticleDetailLoading() extends ArticleDetailState;

class const ArticleDetailLoaded({
  required final Article article,
}) extends ArticleDetailState;

class const ArticleDetailFailure({
  required final AppError error,
}) extends ArticleDetailState;
