import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/vocabulary.dart';

part 'home_state.mapper.dart';

@MappableClass()
sealed class HomeState with HomeStateMappable {
  const HomeState();
}

@MappableClass()
class const HomeLoading() extends HomeState with HomeLoadingMappable;

@MappableClass()
class const HomeLoaded({
  required final List<Vocabulary> vocabularies,
  required final int vocabularyCount,
}) extends HomeState with HomeLoadedMappable;

@MappableClass()
class const HomeFailure({
  required final AppError error,
}) extends HomeState with HomeFailureMappable;
