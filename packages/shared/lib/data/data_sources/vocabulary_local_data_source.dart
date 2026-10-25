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
  Stream<List<LocalVocabulary>> watchVocabularies({required int limit});

  Stream<List<LocalVocabulary>> watchRecentVocabularies({
    required Duration maxAge,
    required int limit,
  });

  // * levelFloors ascend; a level counts from its floor up to the next floor, the lowest level also counts everything below its floor
  Stream<LocalVocabularyOverview> watchOverview({required List<double> levelFloors});

  Future<LocalVocabulary?> findVocabulary(UuidValue id);

  Future<bool> hasVocabularyWithSource(String source);

  Future<int> countDueVocabularies(DateTime dueBy);

  Future<List<LocalVocabulary>> findDueVocabularies({
    required DateTime dueBy,
    required int limit,
  });

  Future<bool> hasDueVocabulariesOutsidePair({
    required DateTime dueBy,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  });

  Future<LocalVocabulary> insertVocabulary(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
  });

  Future<void> saveReview(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
  });

  Future<LocalVocabulary> updateVocabulary(
    LocalVocabulary vocabulary, {
    required ColumnSelections<LocalVocabularyTable> columns,
  });

  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id);
}

@Injectable(as: VocabularyLocalDataSource)
class const VocabularyLocalDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements VocabularyLocalDataSource {
  @override
  Stream<List<LocalVocabulary>> watchVocabularies({required int limit}) {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? Stream.value(const <LocalVocabulary>[])
          : LocalVocabulary.db.watch(session, orderBy: (t) => t.createdAt.desc(), limit: limit),
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
  Stream<LocalVocabularyOverview> watchOverview({required List<double> levelFloors}) {
    return _watchTimed(
      empty: LocalVocabularyOverview(
        totalCount: 0,
        dueCount: 0,
        nextDueAt: null,
        countsByLevelFloor: {for (final floor in levelFloors) floor: 0},
      ),
      query: (session, now) async {
        final nextDue = await LocalVocabulary.db.findFirstRow(
          session,
          where: (t) => t.nextReviewAt > now,
          orderBy: (t) => t.nextReviewAt.asc(),
        );
        final overview = LocalVocabularyOverview(
          totalCount: await LocalVocabulary.db.count(session),
          dueCount: await LocalVocabulary.db.count(session, where: (t) => t.nextReviewAt <= now),
          nextDueAt: nextDue?.nextReviewAt,
          countsByLevelFloor: {
            for (final (index, floor) in levelFloors.indexed)
              floor: await LocalVocabulary.db.count(
                session,
                where: _levelBetween(
                  index == 0 ? null : floor,
                  levelFloors.elementAtOrNull(index + 1),
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
  Future<bool> hasVocabularyWithSource(String source) async {
    final count = await LocalVocabulary.db.count(
      _requireSession(),
      where: (t) => t.source.equals(source),
      limit: 1,
    );
    return count > 0;
  }

  @override
  Future<int> countDueVocabularies(DateTime dueBy) {
    return LocalVocabulary.db.count(_requireSession(), where: (t) => t.nextReviewAt <= dueBy);
  }

  @override
  Future<List<LocalVocabulary>> findDueVocabularies({
    required DateTime dueBy,
    required int limit,
  }) {
    return LocalVocabulary.db.find(
      _requireSession(),
      where: (t) => t.nextReviewAt <= dueBy,
      orderBy: (t) => t.nextReviewAt.asc(),
      limit: limit,
    );
  }

  @override
  Future<bool> hasDueVocabulariesOutsidePair({
    required DateTime dueBy,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  }) async {
    final count = await LocalVocabulary.db.count(
      _requireSession(),
      where: (t) =>
          (t.nextReviewAt <= dueBy) &
          (t.sourceLanguageCode.notEquals(sourceLanguageCode) |
              t.targetLanguageCode.notEquals(targetLanguageCode)),
      limit: 1,
    );
    return count > 0;
  }

  @override
  Future<LocalVocabulary> insertVocabulary(
    LocalVocabulary vocabulary, {
    required LocalActivity activity,
  }) {
    final session = _sessions.requireWritableSession();
    return session.db.transaction((transaction) async {
      final inserted = await LocalVocabulary.db.insertRow(
        session,
        vocabulary,
        transaction: transaction,
      );
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
  }) {
    return LocalVocabulary.db.updateRow(
      _sessions.requireWritableSession(),
      vocabulary,
      columns: columns,
    );
  }

  @override
  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id) {
    return LocalVocabulary.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.id.equals(id),
    );
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

  DatabaseSession _requireSession() {
    final session = _sessions.currentSession;
    if (session == null) throw StateError("No database is open.");
    return session;
  }

  WhereExpressionBuilder<LocalVocabularyTable>? _levelBetween(double? from, double? until) {
    return switch ((from, until)) {
      (null, null) => null,
      (final from?, null) => (t) => t.level >= from,
      (null, final until?) => (t) => t.level < until,
      (final from?, final until?) => (t) => (t.level >= from) & (t.level < until),
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
            .watch(session, limit: 1)
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
