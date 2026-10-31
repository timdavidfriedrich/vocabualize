import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';

part 'home_state.mapper.dart';

@MappableClass()
sealed class HomeState with HomeStateMappable {
  const HomeState();
}

@MappableClass()
class const HomeLoading({
  required final LanguageSetup? setup,
  required final VocabularyOverview? overview,
  required final List<Vocabulary>? recentVocabularies,
  required final List<CollectionPreview>? collections,
  required final List<Vocabulary>? vocabularies,
  required final int feedLimit,
  required final VocabularyFilter filter,
  required final Streak? streak,
}) extends HomeState with HomeLoadingMappable;

@MappableClass()
class const HomeLoaded({
  required final LanguageSetup setup,
  required final VocabularyOverview overview,
  required final List<Vocabulary> recentVocabularies,
  required final List<CollectionPreview> collections,
  required final List<Vocabulary> vocabularies,
  required final int feedLimit,
  required final VocabularyFilter filter,
  required final Streak? streak,
  required final AppError? error,
}) extends HomeState with HomeLoadedMappable;

@MappableClass()
class const HomeFailure({
  required final AppError error,
}) extends HomeState with HomeFailureMappable;
