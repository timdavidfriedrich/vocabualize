import 'package:core/error/app_error.dart';
import 'package:shared/domain/entities/article.dart';

sealed class HomeState {
  const HomeState();
}

class const HomeLoading() extends HomeState;

class const HomeLoaded({
  required final List<Article> articles,
}) extends HomeState;

class const HomeFailure({
  required final AppError error,
}) extends HomeState;
