import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

part 'vocabulary_overview.mapper.dart';

@MappableClass()
class const VocabularyOverview({
  required final int totalCount,
  required final int dueCount,
  required final int waitingCount,
  required final int addedTodayCount,
  required final DateTime? nextDueAt,
  required final int noviceCount,
  required final int beginnerCount,
  required final int advancedCount,
  required final int expertCount,
}) with VocabularyOverviewMappable;

extension VocabularyOverviewExtensions on VocabularyOverview {
  int countOf(VocabularyLevel level) => switch (level) {
    VocabularyLevel.novice => noviceCount,
    VocabularyLevel.beginner => beginnerCount,
    VocabularyLevel.advanced => advancedCount,
    VocabularyLevel.expert => expertCount,
  };
}
