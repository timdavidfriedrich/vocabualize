import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class VocabularyLocalDataSource {
  Stream<List<LocalVocabulary>> watchVocabularies({required int limit});

  Stream<int> watchVocabularyCount();

  Future<LocalVocabulary> insertVocabulary(LocalVocabulary vocabulary);

  Future<void> deleteVocabulary(UuidValue id);
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
  Stream<int> watchVocabularyCount() {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? Stream.value(0)
          : LocalVocabulary.db
                .watch(session, limit: 1)
                .asyncMap((_) => LocalVocabulary.db.count(session)),
    );
  }

  @override
  Future<LocalVocabulary> insertVocabulary(LocalVocabulary vocabulary) {
    return LocalVocabulary.db.insertRow(_requireSession(), vocabulary);
  }

  @override
  Future<void> deleteVocabulary(UuidValue id) async {
    await LocalVocabulary.db.deleteWhere(_requireSession(), where: (t) => t.id.equals(id));
  }

  OfflineSyncDatabaseSession _requireSession() {
    final session = _sessions.currentSession;
    if (session == null) throw StateError("No database is open.");
    return session;
  }
}
