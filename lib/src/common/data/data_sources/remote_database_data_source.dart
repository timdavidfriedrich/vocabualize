import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_connection_client.dart';
import 'package:vocabualize/src/common/data/mappers/report_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_bug_report.dart';
import 'package:vocabualize/src/common/data/models/rdb_translation_report.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';

final remoteDatabaseDataSourceProvider = Provider((ref) {
  return RemoteDatabaseDataSource(
    connectionClient: ref.watch(remoteConnectionClientProvider),
  );
});

class RemoteDatabaseDataSource {
  final RemoteConnectionClient _connectionClient;

  const RemoteDatabaseDataSource({
    required RemoteConnectionClient connectionClient,
  }) : _connectionClient = connectionClient;

  final String _vocabulariesCollectionName = "vocabularies";
  final String _languagesCollectionName = "languages";
  final String _tagsCollectionName = "tags_by_user";
  final String _translationReportCollectionName = "translation_reports";
  final String _bugReportCollectionName = "bug_reports";

  /*
  Future<List<Vocabulary>> _fetchData({required String userId}) async {
    List<Language> languages = await _fetchLanguages();
    List<Tag> tags = await _fetchTags(userId: userId);
    List<Vocabulary> vocabularies = await _fetchVocabularies(userId: userId, languages: languages, tags: tags);
    return vocabularies;
  }

  Future<List<Language>> _fetchLanguages() async {
    final PocketBase pocketbase = await getConnection();
    final languageRecords = await pocketbase.collection(_languagesCollectionName).getList();
    final test = languageRecords.items.map((e) => Language.fromRecord(e)).toList();
    return test;
  }

  Future<List<Tag>> _fetchTags({required String userId}) async {
    final PocketBase pocketbase = await getConnection();
    final String userFilter = "user=\"$userId\"";
    final tagsRecords = await pocketbase.collection(_tagsCollectionName).getList(filter: userFilter);
    final test = tagsRecords.items.map((e) => Tag.fromRecord(e)).toList();
    return test;
  }

  Future<List<Vocabulary>> _fetchVocabularies({required String userId, List<Tag>? tags, List<Language>? languages}) async {
    final PocketBase pocketbase = await getConnection();
    final String userFilter = "user=\"$userId\"";
    final vocabularyRecords = await pocketbase.collection(_vocabulariesCollectionName).getList(filter: userFilter);
    final test = vocabularyRecords.items
        .map((e) => Vocabulary.fromRecord(
              e,
              tags: tags?.where((element) => (e.data["tags"]).contains(element.id)).toList(),
              languages: languages,
            ))
        .toList();
    return test;
  }
  */

  Future<void> sendBugReport(RdbBugReport bugReport) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    await pocketbase.collection(_bugReportCollectionName).create(body: bugReport.toRecordModel().toJson());
  }

  Future<void> sendTranslationReport(RdbTranslationReport translationReport) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    await pocketbase.collection(_translationReportCollectionName).create(body: translationReport.toRecordModel().toJson());
  }

  Future<List<RdbVocabulary>> getVocabularies({
    String? searchTerm,
    Tag? tag,
    String? userId,
  }) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final String searchFilter = searchTerm != null ? "searchTerms contains \"$searchTerm\"" : "";
    final String tagFilter = tag != null ? "tags contains \"${tag.id}\"" : "";
    final String userFilter = userId != null ? "user=\"$userId\"" : "";
    final String filter = [userFilter, tagFilter, searchFilter].where((e) => e.isNotEmpty).join(" AND ");

    return pocketbase.collection(_vocabulariesCollectionName).getList(filter: filter).then((value) async {
      return value.items.map((RecordModel record) => record.toRdbVocabulary()).toList();
    });
  }

  Future<void> addVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final data = vocabulary.toRecordModel().toJson();
    await pocketbase.collection(_vocabulariesCollectionName).create(body: data);
  }

  Future<void> deleteAllVocabularies() async {
    // TODO: Implement deleteAllVocabularies
    //final PocketBase pocketbase = await RemoteDatabaseDataSource.getConnection();
    //await pocketbase.collection(_vocabulariesCollectionName).delete();
  }

  Future<void> deleteVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    await pocketbase.collection(_vocabulariesCollectionName).delete(vocabulary.id);
  }

  Future<void> updateVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final data = vocabulary.toRecordModel().toJson();
    await pocketbase.collection(_vocabulariesCollectionName).update(vocabulary.id, body: data);
  }
}