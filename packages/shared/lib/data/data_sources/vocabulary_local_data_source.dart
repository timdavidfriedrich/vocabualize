import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class VocabularyLocalDataSource {
  Stream<List<LocalVocabulary>> watchVocabularies({required int limit});

  Stream<int> watchVocabularyCount();

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
    return LocalVocabulary.db.insertRow(_sessions.requireWritableSession(), vocabulary);
  }

  @override
  Future<List<LocalVocabulary>> deleteVocabulary(UuidValue id) {
    return LocalVocabulary.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.id.equals(id),
    );
  }
}
