import 'package:dart_mappable/dart_mappable.dart';

part 'local_vocabulary_overview.mapper.dart';

@MappableClass()
class const LocalVocabularyOverview({
  required final int totalCount,
  required final int dueCount,
  required final int waitingCount,
  required final int addedTodayCount,
  required final DateTime? nextDueAt,
  required final Map<double, int> countsByLevelFloor,
}) with LocalVocabularyOverviewMappable;
