import 'package:shared/data/models/local_vocabulary_overview.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';

extension LocalVocabularyOverviewMappers on LocalVocabularyOverview {
  VocabularyOverview toVocabularyOverview() {
    return VocabularyOverview(
      totalCount: totalCount,
      dueCount: dueCount,
      addedTodayCount: addedTodayCount,
      nextDueAt: nextDueAt?.toUtc(),
      noviceCount: _countOf(VocabularyLevel.novice),
      beginnerCount: _countOf(VocabularyLevel.beginner),
      advancedCount: _countOf(VocabularyLevel.advanced),
      expertCount: _countOf(VocabularyLevel.expert),
    );
  }

  int _countOf(VocabularyLevel level) => countsByLevelFloor[level.floor] ?? 0;
}
