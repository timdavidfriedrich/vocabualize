import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class TagLocalDataSource {
  Stream<List<LocalTag>> watchTags();

  Stream<LocalTag?> watchTag(UuidValue id);

  Stream<List<({LocalTag tag, List<LocalVocabulary> newest})>> watchCollections({
    required int previewSize,
  });

  Future<LocalTag> insertTag(LocalTag tag);

  Future<void> renameTag(LocalTag tag);

  Future<void> deleteTag(UuidValue id);
}

@Injectable(as: TagLocalDataSource)
class const TagLocalDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements TagLocalDataSource {
  @override
  Stream<List<LocalTag>> watchTags() {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? Stream.value(const <LocalTag>[])
          : LocalTag.db.watch(session, orderBy: (t) => t.createdAt.asc()),
    );
  }

  @override
  Stream<LocalTag?> watchTag(UuidValue id) {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? Stream.value(null)
          : LocalTag.db
                .watch(session, where: (t) => t.id.equals(id), limit: 1)
                .map((tags) => tags.firstOrNull),
    );
  }

  @override
  Stream<List<({LocalTag tag, List<LocalVocabulary> newest})>> watchCollections({
    required int previewSize,
  }) {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? Stream.value(const [])
          : LocalTag.db
                .watch(
                  session,
                  orderBy: (t) => t.createdAt.asc(),
                  alsoTriggerOnTables: [LocalVocabularyTag.t, LocalVocabulary.t],
                )
                .asyncMap(
                  (tags) async => [
                    for (final tag in tags)
                      if (tag.id case final id?)
                        (tag: tag, newest: await _newest(session, id, previewSize)),
                  ],
                ),
    );
  }

  @override
  Future<LocalTag> insertTag(LocalTag tag) {
    return LocalTag.db.insertRow(_sessions.requireWritableSession(), tag);
  }

  @override
  Future<void> renameTag(LocalTag tag) async {
    await LocalTag.db.updateRow(
      _sessions.requireWritableSession(),
      tag,
      columns: (t) => [t.name],
    );
  }

  @override
  Future<void> deleteTag(UuidValue id) async {
    await LocalTag.db.deleteWhere(
      _sessions.requireWritableSession(),
      where: (t) => t.id.equals(id),
    );
  }

  Future<List<LocalVocabulary>> _newest(DatabaseSession session, UuidValue tagId, int limit) async {
    final links = await LocalVocabularyTag.db.find(session, where: (t) => t.tagId.equals(tagId));
    if (links.isEmpty) return const [];
    final vocabularyIds = {for (final link in links) link.vocabularyId};
    return LocalVocabulary.db.find(
      session,
      where: (t) => t.id.inSet(vocabularyIds),
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
    );
  }
}
