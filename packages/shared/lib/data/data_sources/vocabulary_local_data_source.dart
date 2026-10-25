import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/models/local_vocabulary_overview.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

typedef _TimedResult<T> = ({T value, DateTime? validUntil});

typedef _TimedQuery<T> = Future<_TimedResult<T>> Function(DatabaseSession session, DateTime now);

abstract class VocabularyLocalDataSource {
  Stream<List<LocalVocabulary>> watchVocabularies({
    required int limit,
    required UuidValue? tagId,
  });

  Stream<List<LocalVocabulary>> watchRecentVocabularies({
    required Duration maxAge,
    required int limit,
  });

  // * levelFloors ascend; a level counts from its floor up to the next floor, the lowest level also counts everything below its floor
  Stream<LocalVocabularyOverview> watchOverview({
    required List<double> levelFloors,
    required UuidValue? tagId,
  });

  Future<LocalVocabulary?> findVocabulary(UuidValue id);

  Future<List<LocalVocabularyTag>> findTagLinks(Set<UuidValue> vocabularyIds);

  Future<bool> hasVocabularyWithSource(String source);

  Future<int> countDueVocabularies({
    required DateTime dueBy,
    required UuidValue? tagId,
  });

  Future<List<LocalVocabulary>> findDueVocabularies({
    required DateTime dueBy,
    required int limit,
    required UuidValue? tagId,
  });

  Future<bool> hasDueVocabulariesOutsidePair({
    required DateTime dueBy,
    required String sourceLanguageCode,
    required String targetLanguageCode,
    required UuidValue? tagId,
  });

  Future<LocalVocabulary> insertVocabulary(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
    required Set<UuidValue> tagIds,
  });

  Future<void> saveReview(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
  });

  Future<LocalVocabulary> updateVocabulary(
    LocalVocabulary vocabulary, {
    required ColumnSelections<LocalVocabularyTable> columns,
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
    required int limit,
    required UuidValue? tagId,
  }) {
    return _watchTimed(
      empty: const <LocalVocabulary>[],
      query: (session, now) async {
        final scope = await _scope(session, tagId);
        final vocabularies = await LocalVocabulary.db.find(
          session,
          where: _onlyIn(scope),
          orderBy: (t) => t.createdAt.desc(),
          limit: limit,
        );
        return (value: vocabularies, validUntil: null);
      },
    );
  }

  @override
  Stream<List<LocalVocabulary>> watchRecentVocabularies({
    required Duration maxAge,
    required int limit,
  }) {
    return _watchTimed(
      empty: const <LocalVocabulary>[],
      query: (session, now) async {
        final vocabularies = await LocalVocabulary.db.find(
          session,
          where: (t) => t.createdAt > now.subtract(maxAge),
          orderBy: (t) => t.createdAt.desc(),
          limit: limit,
        );
        return (value: vocabularies, validUntil: vocabularies.lastOrNull?.createdAt.add(maxAge));
      },
    );
  }

  @override
  Stream<LocalVocabularyOverview> watchOverview({
    required List<double> levelFloors,
    required UuidValue? tagId,
  }) {
    return _watchTimed(
      empty: LocalVocabularyOverview(
        totalCount: 0,
        dueCount: 0,
        nextDueAt: null,
        countsByLevelFloor: {for (final floor in levelFloors) floor: 0},
      ),
      query: (session, now) async {
        final scope = await _scope(session, tagId);
        final nextDue = await LocalVocabulary.db.findFirstRow(
          session,
          where: (t) => _within(t, t.nextReviewAt > now, scope),
          orderBy: (t) => t.nextReviewAt.asc(),
        );
        final overview = LocalVocabularyOverview(
          totalCount: await LocalVocabulary.db.count(session, where: _onlyIn(scope)),
          dueCount: await LocalVocabulary.db.count(
            session,
            where: (t) => _within(t, t.nextReviewAt <= now, scope),
          ),
          nextDueAt: nextDue?.nextReviewAt,
          countsByLevelFloor: {
            for (final (index, floor) in levelFloors.indexed)
              floor: await LocalVocabulary.db.count(
                session,
                where: (t) => _within(
                  t,
                  _levelBetween(
                    t,
                    index == 0 ? null : floor,
                    levelFloors.elementAtOrNull(index + 1),
                  ),
                  scope,
                ),
              ),
          },
        );
        return (value: overview, validUntil: nextDue?.nextReviewAt);
      },
    );
  }

  @override
  Future<LocalVocabulary?> findVocabulary(UuidValue id) {
    return LocalVocabulary.db.findById(_requireSession(), id);
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
  Future<bool> hasVocabularyWithSource(String source) async {
    final count = await LocalVocabulary.db.count(
      _requireSession(),
      where: (t) => t.source.equals(source),
      limit: 1,
    );
    return count > 0;
  }

  @override
  Future<int> countDueVocabularies({
    required DateTime dueBy,
    required UuidValue? tagId,
  }) async {
    final session = _requireSession();
    final scope = await _scope(session, tagId);
    return LocalVocabulary.db.count(
      session,
      where: (t) => _within(t, t.nextReviewAt <= dueBy, scope),
    );
  }

  @override
  Future<List<LocalVocabulary>> findDueVocabularies({
    required DateTime dueBy,
    required int limit,
    required UuidValue? tagId,
  }) async {
    final session = _requireSession();
    final scope = await _scope(session, tagId);
    return LocalVocabulary.db.find(
      session,
      where: (t) => _within(t, t.nextReviewAt <= dueBy, scope),
      orderBy: (t) => t.nextReviewAt.asc(),
      limit: limit,
    );
  }

  @override
  Future<bool> hasDueVocabulariesOutsidePair({
    required DateTime dueBy,
    required String sourceLanguageCode,
    required String targetLanguageCode,
    required UuidValue? tagId,
  }) async {
    final session = _requireSession();
    final scope = await _scope(session, tagId);
    final count = await LocalVocabulary.db.count(
      session,
      where: (t) => _within(
        t,
        (t.nextReviewAt <= dueBy) &
            (t.sourceLanguageCode.notEquals(sourceLanguageCode) |
                t.targetLanguageCode.notEquals(targetLanguageCode)),
        scope,
      ),
      limit: 1,
    );
    return count > 0;
  }

  @override
  Future<LocalVocabulary> insertVocabulary(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
    required Set<UuidValue> tagIds,
  }) {
    final session = _sessions.requireWritableSession();
    return session.db.transaction((transaction) async {
      final inserted = await LocalVocabulary.db.insertRow(
        session,
        vocabulary,
        transaction: transaction,
      );
      if (inserted.id case final id?) await _replaceTagLinks(session, id, tagIds, transaction);
      await _recordActivity(session, activity, transaction);
      return inserted;
    });
  }

  @override
  Future<void> saveReview(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
  }) {
    final session = _sessions.requireWritableSession();
    return session.db.transaction((transaction) async {
      await LocalVocabulary.db.updateRow(
        session,
        vocabulary,
        columns: (t) => [t.level, t.isNovice, t.intervalMinutes, t.ease, t.nextReviewAt],
        transaction: transaction,
      );
      await _recordActivity(session, activity, transaction);
    });
  }

  @override
  Future<LocalVocabulary> updateVocabulary(
    LocalVocabulary vocabulary, {
    required ColumnSelections<LocalVocabularyTable> columns,
    required Set<UuidValue> tagIds,
  }) {
    final session = _sessions.requireWritableSession();
    return session.db.transaction((transaction) async {
      final updated = await LocalVocabulary.db.updateRow(
        session,
        vocabulary,
        columns: columns,
        transaction: transaction,
      );
      if (updated.id case final id?) await _replaceTagLinks(session, id, tagIds, transaction);
      return updated;
    });
  }

  @override
  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id) {
    return LocalVocabulary.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.id.equals(id),
    );
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
    LocalActivity activity,
    Transaction transaction,
  ) async {
    final existing = await LocalActivity.db.count(
      session,
      where: (t) => t.type.equals(activity.type) & t.localDate.equals(activity.localDate),
      limit: 1,
      transaction: transaction,
    );
    if (existing == 0) {
      await LocalActivity.db.insertRow(session, activity, transaction: transaction);
    }
  }

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

  WhereExpressionBuilder<LocalVocabularyTable>? _onlyIn(Set<UuidValue>? scope) {
    return scope == null ? null : (t) => t.id.inSet(scope);
  }

  DatabaseSession _requireSession() {
    final session = _sessions.currentSession;
    if (session == null) throw StateError("No database is open.");
    return session;
  }

  Expression<dynamic> _levelBetween(LocalVocabularyTable t, double? from, double? until) {
    return switch ((from, until)) {
      (null, null) => t.level.notEquals(null),
      (final from?, null) => t.level >= from,
      (null, final until?) => t.level < until,
      (final from?, final until?) => (t.level >= from) & (t.level < until),
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
              alsoTriggerOnTables: [LocalVocabularyTag.t, LocalTag.t],
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
