import 'package:dart_mappable/dart_mappable.dart';

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
