import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_session.dart';
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
  required final CustomPracticeSession? customSession,
  required final int? allWordsCount,
  required final VocabularyOverview? overview,
  required final Map<Language, VocabularyOverview> overviews,
  required final List<Vocabulary> importWords,
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
  required final CustomPracticeSession? customSession,
  required final int allWordsCount,
  required final VocabularyOverview overview,
  required final Map<Language, VocabularyOverview> overviews,
  required final List<Vocabulary> importWords,
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

extension HomeLoadedExtensions on HomeLoaded {
  bool get isLanguageEmpty => overview.totalCount == 0 && vocabularies.isEmpty && allWordsCount > 0;

  Language? get importSource {
    final candidates = [
      for (final learned in setup.active)
        if (learned.language != setup.selected &&
            (overviews[learned.language]?.totalCount ?? 0) > 0)
          learned.language,
    ];
    candidates.sort(
      (first, second) => overviews[second]!.totalCount.compareTo(overviews[first]!.totalCount),
    );
    return candidates.firstOrNull;
  }
}
