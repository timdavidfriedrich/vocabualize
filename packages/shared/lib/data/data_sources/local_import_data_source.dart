import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class LocalImportDataSource {
  Future<void> importSnapshot(LocalSnapshot snapshot);
}

@Injectable(as: LocalImportDataSource)
class const LocalImportDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements LocalImportDataSource {
  @override
  Future<void> importSnapshot(LocalSnapshot snapshot) async {
    final session = _sessions.currentSession;
    if (session == null) throw StateError("No database is open to import into.");
    final vocabularyIds = {
      for (final vocabulary in snapshot.vocabularies) ?vocabulary.id: _newId(),
    };
    final tagIds = {
      for (final tag in snapshot.tags) ?tag.id: _newId(),
    };
    final tags = [
      for (final tag in snapshot.tags)
        if (tagIds[tag.id] case final id?) tag.copyWith(id: id, spaceId: null),
    ];
    final vocabularies = [
      for (final vocabulary in snapshot.vocabularies)
        if (vocabularyIds[vocabulary.id] case final id?) vocabulary.copyWith(id: id, spaceId: null),
    ];
    final vocabularyTags = [
      for (final link in snapshot.vocabularyTags)
        if ((vocabularyIds[link.vocabularyId], tagIds[link.tagId]) case (
          final vocabularyId?,
          final tagId?,
        ))
          LocalVocabularyTag(id: _newId(), vocabularyId: vocabularyId, tagId: tagId),
    ];
    final activities = [
      for (final activity in snapshot.activities) activity.copyWith(id: _newId(), spaceId: null),
    ];
    await session.db.transaction((transaction) async {
      await LocalTag.db.insert(session, tags, transaction: transaction);
      await LocalVocabulary.db.insert(session, vocabularies, transaction: transaction);
      await LocalVocabularyTag.db.insert(session, vocabularyTags, transaction: transaction);
      await LocalActivity.db.insert(session, activities, transaction: transaction);
    });
  }

  UuidValue _newId() => const Uuid().v7obj();
}
