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

  Future<LocalVocabulary> insertVocabulary(LocalVocabulary vocabulary);

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
  Future<LocalVocabulary> insertVocabulary(LocalVocabulary vocabulary) {
    return LocalVocabulary.db.insertRow(_sessions.requireWritableSession(), vocabulary);
  }

  @override
  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id) {
    return LocalVocabulary.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.id.equals(id),
    );
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
