import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/models/local_activity_day.dart';
import 'package:shared/data/models/local_level_range.dart';
import 'package:shared/data/models/local_progress_stage.dart';
import 'package:shared/data/models/local_vocabulary_overview.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

typedef _TimedResult<T> = ({T value, DateTime? validUntil});

typedef _TimedQuery<T> = Future<_TimedResult<T>> Function(DatabaseSession session, DateTime now);

const _anyCharacters = "%";

abstract class VocabularyLocalDataSource {
  Stream<List<LocalVocabulary>> watchVocabularies({
    required String languageCode,
    required int limit,
    required UuidValue? tagId,
    required String query,
    required List<LocalLevelRange> levelRanges,
    required bool isDueOnly,
  });

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
    required UuidValue? tagId,
  });

  Future<List<LocalProgress>> findDueProgress({
    required Set<String> languageCodes,
    required DateTime dueBy,
    required int limit,
    required UuidValue? tagId,
  });

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

  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id);
}

@Injectable(as: VocabularyLocalDataSource)
class const VocabularyLocalDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements VocabularyLocalDataSource {
  @override
  Stream<List<LocalVocabulary>> watchVocabularies({
    required String languageCode,
    required int limit,
    required UuidValue? tagId,
    required String query,
    required List<LocalLevelRange> levelRanges,
    required bool isDueOnly,
  }) {
    return _watchTimed(
      empty: const <LocalVocabulary>[],
      query: (session, now) async {
        final scope = await _scope(session, tagId);
        final vocabularies = await LocalVocabulary.db.find(
          session,
          where: (t) => _within(
            t,
            _allOf(
              t.progress.any(
                (progress) => _allOf(progress.languageCode.equals(languageCode), [
                  ?_anyOf([
                    for (final range in levelRanges)
                      _levelBetween(progress, range.from, range.until),
                  ]),
                  if (isDueOnly) _isDue(progress, now),
                ]),
              ),
              [
                if (query.isNotEmpty)
                  t.translations.any(
                    (translation) =>
                        translation.text.ilike("$_anyCharacters$query$_anyCharacters"),
                  ),
              ],
            ),
            scope,
          ),
          orderBy: (t) => t.createdAt.desc(),
          limit: limit,
          include: _withLanguages(),
        );
        final nextDue = isDueOnly
            ? await LocalProgress.db.findFirstRow(
                session,
                where: (progress) => _progressWithin(
                  progress,
                  _allOf(progress.languageCode.equals(languageCode), [
                    progress.stage.inSet(startedProgressStages),
                    progress.nextReviewAt > now,
                  ]),
                  scope,
                ),
                orderBy: (progress) => progress.nextReviewAt.asc(),
              )
            : null;
        return (value: vocabularies, validUntil: nextDue?.nextReviewAt);
      },
    );
  }

  @override
  Stream<List<LocalVocabulary>> watchRecentVocabularies({
    required String languageCode,
    required Duration maxAge,
    required int limit,
  }) {
    return _watchTimed(
      empty: const <LocalVocabulary>[],
      query: (session, now) async {
        final vocabularies = await LocalVocabulary.db.find(
          session,
          where: (t) =>
              (t.createdAt > now.subtract(maxAge)) &
              t.progress.any((progress) => progress.languageCode.equals(languageCode)),
          orderBy: (t) => t.createdAt.desc(),
          limit: limit,
          include: _withLanguages(),
        );
        return (value: vocabularies, validUntil: vocabularies.lastOrNull?.createdAt.add(maxAge));
      },
    );
  }

  @override
  Stream<LocalVocabularyOverview> watchOverview({
    required Set<String> languageCodes,
    required List<double> levelFloors,
    required UuidValue? tagId,
  }) {
    return _watchTimed(
      empty: LocalVocabularyOverview(
        totalCount: 0,
        dueCount: 0,
        waitingCount: 0,
        addedTodayCount: 0,
        nextDueAt: null,
        countsByLevelFloor: {for (final floor in levelFloors) floor: 0},
      ),
      query: (session, now) async {
        final scope = await _scope(session, tagId);
        final today = now.toLocal();
        final startOfToday = DateTime(today.year, today.month, today.day).toUtc();
        final startOfTomorrow = DateTime(today.year, today.month, today.day + 1).toUtc();
        Expression<dynamic> inLanguages(LocalProgressTable progress, [Expression<dynamic>? and]) =>
            _progressWithin(
              progress,
              _allOf(progress.languageCode.inSet(languageCodes), [and]),
              scope,
            );
        final nextDue = await LocalProgress.db.findFirstRow(
          session,
          where: (progress) => inLanguages(
            progress,
            progress.stage.inSet(startedProgressStages) & (progress.nextReviewAt > now),
          ),
          orderBy: (progress) => progress.nextReviewAt.asc(),
        );
        final nextDueAt = nextDue?.nextReviewAt;
        var waitingCount = 0;
        for (final languageCode in languageCodes) {
          waitingCount += await LocalProgress.db.count(
            session,
            where: (progress) => _progressWithin(
              progress,
              _allOf(progress.languageCode.equals(languageCode), [
                progress.stage.equals(LocalProgressStage.waiting.value),
                progress.vocabulary.translations.any(
                  (translation) => translation.languageCode.equals(languageCode),
                ),
              ]),
              scope,
            ),
          );
        }
        final overview = LocalVocabularyOverview(
          totalCount: await LocalProgress.db.count(session, where: inLanguages),
          dueCount: await LocalProgress.db.count(
            session,
            where: (progress) => inLanguages(progress, _isDue(progress, now)),
          ),
          waitingCount: waitingCount,
          addedTodayCount: await LocalProgress.db.count(
            session,
            where: (progress) =>
                inLanguages(progress, progress.vocabulary.createdAt >= startOfToday),
          ),
          nextDueAt: nextDueAt,
          countsByLevelFloor: {
            for (final (index, floor) in levelFloors.indexed)
              floor: await LocalProgress.db.count(
                session,
                where: (progress) => inLanguages(
                  progress,
                  _levelBetween(
                    progress,
                    index == 0 ? null : floor,
                    levelFloors.elementAtOrNull(index + 1),
                  ),
                ),
              ),
          },
        );
        return (
          value: overview,
          validUntil: nextDueAt != null && nextDueAt.isBefore(startOfTomorrow)
              ? nextDueAt
              : startOfTomorrow,
        );
      },
    );
  }

  @override
  Future<LocalVocabulary?> findVocabulary(UuidValue id) {
    return LocalVocabulary.db.findById(_requireSession(), id, include: _withLanguages());
  }

  @override
  Future<List<LocalVocabulary>> findVocabulariesWithText({
    required String languageCode,
    required String text,
  }) async {
    final normalized = text.trim().toLowerCase();
    final candidates = await LocalVocabulary.db.find(
      _requireSession(),
      where: (t) => t.translations.any(
        (translation) =>
            translation.languageCode.equals(languageCode) & translation.text.ilike(text.trim()),
      ),
      include: _withLanguages(),
    );
    return [
      for (final candidate in candidates)
        if (candidate.translations?.any(
              (translation) =>
                  translation.languageCode == languageCode &&
                  translation.text.trim().toLowerCase() == normalized,
            ) ??
            false)
          candidate,
    ];
  }

  @override
  Future<List<LocalVocabularyTag>> findTagLinks(Set<UuidValue> vocabularyIds) async {
    if (vocabularyIds.isEmpty) return const [];
    return LocalVocabularyTag.db.find(
      _requireSession(),
      where: (t) => t.vocabularyId.inSet(vocabularyIds),
    );
  }

  @override
  Future<int> countDueProgress({
    required Set<String> languageCodes,
    required DateTime dueBy,
    required UuidValue? tagId,
  }) async {
    final session = _requireSession();
    final scope = await _scope(session, tagId);
    return LocalProgress.db.count(
      session,
      where: (progress) => _progressWithin(
        progress,
        progress.languageCode.inSet(languageCodes) & _isDue(progress, dueBy),
        scope,
      ),
    );
  }

  @override
  Future<List<LocalProgress>> findDueProgress({
    required Set<String> languageCodes,
    required DateTime dueBy,
    required int limit,
    required UuidValue? tagId,
  }) async {
    final session = _requireSession();
    final scope = await _scope(session, tagId);
    return LocalProgress.db.find(
      session,
      where: (progress) => _progressWithin(
        progress,
        progress.languageCode.inSet(languageCodes) & _isDue(progress, dueBy),
        scope,
      ),
      orderBy: (progress) => progress.nextReviewAt.asc(),
      limit: limit,
      include: LocalProgress.include(vocabulary: _withLanguages()),
    );
  }

  @override
  Future<LocalVocabulary> insertVocabulary(
    LocalVocabulary vocabulary, {
    required List<LocalTranslation> translations,
    required List<LocalProgress> progress,
    required LocalActivityDay activityDay,
    required Set<UuidValue> tagIds,
  }) async {
    final session = _sessions.requireWritableSession();
    final id = await session.db.transaction((transaction) async {
      final inserted = await LocalVocabulary.db.insertRow(
        session,
        vocabulary,
        transaction: transaction,
      );
      final id = inserted.id;
      if (id == null) throw StateError("An inserted vocabulary has no id.");
      await LocalTranslation.db.insert(session, translations, transaction: transaction);
      await LocalProgress.db.insert(session, progress, transaction: transaction);
      await _replaceTagLinks(session, id, tagIds, transaction);
      await _recordActivity(session, activityDay, answers: 0, transaction: transaction);
      return id;
    });
    return _requireVocabulary(session, id);
  }

  @override
  Future<void> saveReview(
    LocalProgress progress, {
    required LocalActivityDay activityDay,
  }) {
    final session = _sessions.requireWritableSession();
    return session.db.transaction((transaction) async {
      await LocalProgress.db.updateRow(
        session,
        progress,
        columns: (t) => [t.stage, t.level, t.intervalMinutes, t.ease, t.nextReviewAt],
        transaction: transaction,
      );
      await _recordActivity(session, activityDay, answers: 1, transaction: transaction);
    });
  }

  @override
  Future<LocalVocabulary> updateVocabulary(
    LocalVocabulary vocabulary, {
    required ColumnSelections<LocalVocabularyTable>? columns,
    required List<LocalTranslation> translations,
    required List<LocalProgress> addedProgress,
    required Set<String> removedLanguageCodes,
    required Set<UuidValue> tagIds,
  }) async {
    final session = _sessions.requireWritableSession();
    final id = vocabulary.id;
    if (id == null) throw StateError("A vocabulary to update has no id.");
    await session.db.transaction((transaction) async {
      if (columns != null) {
        await LocalVocabulary.db.updateRow(
          session,
          vocabulary,
          columns: columns,
          transaction: transaction,
        );
      }
      final existingTranslations = {
        for (final translation in await LocalTranslation.db.find(
          session,
          where: (t) => t.vocabularyId.equals(id),
          transaction: transaction,
        ))
          translation.id: translation,
      };
      for (final translation in translations) {
        switch (existingTranslations[translation.id]) {
          case null:
            await LocalTranslation.db.insertRow(session, translation, transaction: transaction);
          case final existing
              when existing.text != translation.text || existing.origin != translation.origin:
            await LocalTranslation.db.updateRow(
              session,
              translation,
              columns: (t) => [t.text, t.origin],
              transaction: transaction,
            );
          case _:
            break;
        }
      }
      final existingProgressIds = {
        for (final progress in await LocalProgress.db.find(
          session,
          where: (t) => t.vocabularyId.equals(id),
          transaction: transaction,
        ))
          progress.id,
      };
      final newProgress = [
        for (final progress in addedProgress)
          if (!existingProgressIds.contains(progress.id)) progress,
      ];
      if (newProgress.isNotEmpty) {
        await LocalProgress.db.insert(session, newProgress, transaction: transaction);
      }
      if (removedLanguageCodes.isNotEmpty) {
        await LocalProgress.db.deleteWhere(
          session,
          where: (t) => t.vocabularyId.equals(id) & t.languageCode.inSet(removedLanguageCodes),
          transaction: transaction,
        );
      }
      await _replaceTagLinks(session, id, tagIds, transaction);
    });
    return _requireVocabulary(session, id);
  }

  @override
  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id) {
    return LocalVocabulary.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.id.equals(id),
    );
  }

  Future<LocalVocabulary> _requireVocabulary(DatabaseSession session, UuidValue id) async {
    final vocabulary = await LocalVocabulary.db.findById(session, id, include: _withLanguages());
    if (vocabulary == null) throw StateError("The vocabulary $id is missing.");
    return vocabulary;
  }

  Future<void> _replaceTagLinks(
    DatabaseSession session,
    UuidValue vocabularyId,
    Set<UuidValue> tagIds,
    Transaction transaction,
  ) async {
    final existing = await LocalVocabularyTag.db.find(
      session,
      where: (t) => t.vocabularyId.equals(vocabularyId),
      transaction: transaction,
    );
    final existingTagIds = {for (final link in existing) link.tagId};
    final removedLinkIds = {
      for (final link in existing)
        if (!tagIds.contains(link.tagId)) ?link.id,
    };
    if (removedLinkIds.isNotEmpty) {
      await LocalVocabularyTag.db.deleteWhere(
        session,
        where: (t) => t.id.inSet(removedLinkIds),
        transaction: transaction,
      );
    }
    final addedLinks = [
      for (final tagId in tagIds.difference(existingTagIds))
        LocalVocabularyTag(id: const Uuid().v7obj(), vocabularyId: vocabularyId, tagId: tagId),
    ];
    if (addedLinks.isNotEmpty) {
      await LocalVocabularyTag.db.insert(session, addedLinks, transaction: transaction);
    }
  }

  Future<void> _recordActivity(
    DatabaseSession session,
    LocalActivityDay activityDay, {
    required int answers,
    required Transaction transaction,
  }) async {
    final existing = await LocalActivity.db.findFirstRow(
      session,
      where: (t) =>
          t.localDate.equals(activityDay.localDate) & t.deviceId.equals(activityDay.deviceId),
      transaction: transaction,
    );
    if (existing == null) {
      await LocalActivity.db.insertRow(
        session,
        LocalActivity(
          id: const Uuid().v7obj(),
          localDate: activityDay.localDate,
          deviceId: activityDay.deviceId,
          practicedCount: answers,
        ),
        transaction: transaction,
      );
    } else if (answers > 0) {
      await LocalActivity.db.updateRow(
        session,
        existing.copyWith(practicedCount: existing.practicedCount + answers),
        columns: (t) => [t.practicedCount],
        transaction: transaction,
      );
    }
  }

  LocalVocabularyInclude _withLanguages() => LocalVocabulary.include(
    translations: LocalTranslation.includeList(),
    progress: LocalProgress.includeList(),
  );

  Future<Set<UuidValue>?> _scope(DatabaseSession session, UuidValue? tagId) async {
    if (tagId == null) return null;
    final links = await LocalVocabularyTag.db.find(
      session,
      where: (t) => t.tagId.equals(tagId),
    );
    return {for (final link in links) link.vocabularyId};
  }

  Expression<dynamic> _within(
    LocalVocabularyTable t,
    Expression<dynamic> condition,
    Set<UuidValue>? scope,
  ) {
    return scope == null ? condition : condition & t.id.inSet(scope);
  }

  Expression<dynamic> _progressWithin(
    LocalProgressTable progress,
    Expression<dynamic> condition,
    Set<UuidValue>? scope,
  ) {
    return scope == null ? condition : condition & progress.vocabularyId.inSet(scope);
  }

  Expression<dynamic> _isDue(LocalProgressTable progress, DateTime dueBy) {
    return progress.stage.inSet(startedProgressStages) & (progress.nextReviewAt <= dueBy);
  }

  Expression<dynamic> _allOf(Expression<dynamic> first, List<Expression<dynamic>?> others) {
    return others.nonNulls.fold(first, (combined, expression) => combined & expression);
  }

  Expression<dynamic>? _anyOf(List<Expression<dynamic>> expressions) {
    return expressions.fold<Expression<dynamic>?>(
      null,
      (combined, expression) => combined == null ? expression : combined | expression,
    );
  }

  DatabaseSession _requireSession() {
    final session = _sessions.currentSession;
    if (session == null) throw StateError("No database is open.");
    return session;
  }

  Expression<dynamic> _levelBetween(LocalProgressTable progress, double? from, double? until) {
    return switch ((from, until)) {
      (null, null) => progress.level.notEquals(null),
      (final from?, null) => progress.level >= from,
      (null, final until?) => progress.level < until,
      (final from?, final until?) => (progress.level >= from) & (progress.level < until),
    };
  }

  Stream<T> _watchTimed<T>({
    required T empty,
    required _TimedQuery<T> query,
  }) {
    return _sessions.watchSession().switchMap(
      (session) => session == null ? Stream.value(empty) : _watchSessionTimed(session, query),
    );
  }

  Stream<T> _watchSessionTimed<T>(DatabaseSession session, _TimedQuery<T> query) {
    Timer? staleTimer;
    AppLifecycleListener? lifecycleListener;
    StreamSubscription<void>? changeSubscription;
    var isCancelled = false;
    late final StreamController<void> triggers;
    triggers = StreamController<void>(
      onListen: () {
        changeSubscription = LocalVocabulary.db
            .watch(
              session,
              limit: 1,
              alsoTriggerOnTables: [
                LocalTranslation.t,
                LocalProgress.t,
                LocalVocabularyTag.t,
                LocalTag.t,
              ],
            )
            .listen((_) => triggers.add(null), onError: triggers.addError);
        lifecycleListener = AppLifecycleListener(onResume: () => triggers.add(null));
      },
      onCancel: () async {
        isCancelled = true;
        staleTimer?.cancel();
        lifecycleListener?.dispose();
        await changeSubscription?.cancel();
      },
    );
    return triggers.stream.asyncMap((_) async {
      final now = DateTime.now().toUtc();
      final result = await query(session, now);
      staleTimer?.cancel();
      if (result.validUntil case final validUntil? when !isCancelled) {
        staleTimer = Timer(validUntil.difference(now), () => triggers.add(null));
      }
      return result.value;
    });
  }
}
