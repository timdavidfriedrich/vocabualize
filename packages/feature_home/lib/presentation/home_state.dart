import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';

part 'home_state.mapper.dart';

@MappableClass()
sealed class HomeState with HomeStateMappable {
  const HomeState();
}

@MappableClass()
class const HomeLoading({
  required final VocabularyOverview? overview,
  required final List<Vocabulary>? recentVocabularies,
  required final List<Vocabulary>? vocabularies,
  required final int feedLimit,
}) extends HomeState with HomeLoadingMappable;

@MappableClass()
class const HomeLoaded({
  required final VocabularyOverview overview,
  required final List<Vocabulary> recentVocabularies,
  required final List<Vocabulary> vocabularies,
  required final int feedLimit,
  required final AppError? error,
}) extends HomeState with HomeLoadedMappable;

@MappableClass()
class const HomeFailure({
  required final AppError error,
}) extends HomeState with HomeFailureMappable;
