import 'dart:async';

import 'package:serverpod_database/serverpod_database.dart';
import 'package:shared/data/models/local_activity_day.dart';
import 'package:shared/data/models/local_language_membership.dart';
import 'package:shared/data/models/local_level_range.dart';
import 'package:shared/data/models/local_vocabulary_overview.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class VocabularyLocalDataSource {
  Stream<List<LocalVocabulary>> watchVocabularies({
    required String languageCode,
    required int limit,
    required UuidValue? tagId,
    required String query,
    required List<LocalLevelRange> levelRanges,
    required bool isDueOnly,
  });

  Stream<int> watchVocabularyCount();

  Stream<List<LocalVocabulary>> watchRecentVocabularies({
    required String languageCode,
    required Duration maxAge,
    required int limit,
  });

  // * levelFloors ascend; a level counts from its floor up to the next floor, the lowest level also counts everything below its floor
  Stream<LocalVocabularyOverview> watchOverview({
    required Set<String> languageCodes,
    required List<double> levelFloors,
    required UuidValue? tagId,
  });

  Future<LocalVocabulary?> findVocabulary(UuidValue id);

  Future<List<LocalVocabulary>> findVocabulariesWithText({
    required String languageCode,
    required String text,
  });

  Future<List<LocalVocabularyTag>> findTagLinks(Set<UuidValue> vocabularyIds);

  Future<int> countDueProgress({
    required Set<String> languageCodes,
    required DateTime dueBy,
    required Set<UuidValue> tagIds,
  });

  Future<List<LocalProgress>> findDueProgress({
    required Set<String> languageCodes,
    required DateTime dueBy,
    required int limit,
    required Set<UuidValue> tagIds,
  });

  Future<List<LocalProgress>> findWaitingProgress({
    required String languageCode,
    required int limit,
    required int offset,
    required Set<UuidValue> tagIds,
  });

  Future<int> countStartedProgress({
    required Set<String> languageCodes,
    required Set<UuidValue> tagIds,
  });

  Future<int> countWaitingProgress({
    required String languageCode,
    required Set<UuidValue> tagIds,
  });

  Future<List<LocalProgress>> findStartedProgress({
    required Set<String> languageCodes,
    required int limit,
    required Set<UuidValue> tagIds,
  });

  Future<List<LocalProgress>> findProgressByIds(Set<UuidValue> ids);

  Future<void> recordPractice({required LocalActivityDay activityDay});

  Future<LocalVocabulary> insertVocabulary(
    LocalVocabulary vocabulary, {
    required List<LocalTranslation> translations,
    required List<LocalProgress> progress,
    required LocalActivityDay activityDay,
    required Set<UuidValue> tagIds,
  });

  Future<void> saveReview(
    LocalProgress progress, {
    required LocalActivityDay activityDay,
  });

  Future<LocalVocabulary> updateVocabulary(
    LocalVocabulary vocabulary, {
    required ColumnSelections<LocalVocabularyTable>? columns,
    required List<LocalTranslation> translations,
    required List<LocalProgress> addedProgress,
    required Set<String> removedLanguageCodes,
    required Set<UuidValue> tagIds,
  });

  Future<LocalVocabulary?> saveTranslations(
    UuidValue vocabularyId,
    List<LocalTranslation> translations,
  );

  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id);

  Future<List<LocalVocabulary>> findVocabulariesMissingTranslation({
    required String languageCode,
    required String? progressLanguageCode,
    required int limit,
  });

  Future<void> insertMissingTranslations(List<LocalTranslation> translations);

  Stream<LocalLanguageMembership> watchLanguageMembership(String languageCode);

  Future<LocalLanguageMembership> readLanguageMembership(String languageCode);

  Future<List<LocalProgress>> findProgress(String languageCode);

  Future<void> insertMissingProgress(List<LocalProgress> progress);

  Future<void> resetProgress(List<LocalProgress> progress);

  Future<void> deleteProgress({
    required String languageCode,
    required Set<UuidValue>? vocabularyIds,
  });

  Future<void> deleteTranslations({
    required String languageCode,
    required Set<String> keptOrigins,
  });
}
