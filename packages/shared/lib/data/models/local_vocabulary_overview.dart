class const LocalVocabularyOverview({
  required final int totalCount,
  required final int dueCount,
  required final int addedTodayCount,
  required final DateTime? nextDueAt,
  required final Map<double, int> countsByLevelFloor,
});
