import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_connection_client.dart';
import 'package:vocabualize/src/common/data/mappers/language_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/report_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/tag_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_bug_report.dart';
import 'package:vocabualize/src/common/data/models/rdb_language.dart';
import 'package:vocabualize/src/common/data/models/rdb_event_type.dart';
import 'package:vocabualize/src/common/data/models/rdb_tag.dart';
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
  final String _tagsCollectionName = "tags";
  final String _tagsByUserViewName = "tags_by_user";
  final String _translationReportCollectionName = "translation_reports";
  final String _bugReportCollectionName = "bug_reports";
  final String _userFieldName = "user";
  final String _customImageFieldName = "custimImage";

  /*
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

  Future<List<RdbLanguage>> getAvailabeLanguages() async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final languageRecords = await pocketbase.collection(_languagesCollectionName).getList();
    return languageRecords.items.map((record) => record.toRdbLanguage()).toList();
  }

  Future<RdbLanguage> getLanguageById(String id) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final languageRecord = await pocketbase.collection(_languagesCollectionName).getOne(id);
    return languageRecord.toRdbLanguage();
  }

  Future<List<RdbTag>> getTags({String? userId}) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final String? userFilter = userId != null ? "$_userFieldName=\"$userId\"" : null;
    final tagsRecords = await pocketbase.collection(_tagsByUserViewName).getList(filter: userFilter);
    return tagsRecords.items.map((record) => record.toRdbTag()).toList();
  }

  Future<RdbTag> getTagById(String id) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final tagRecord = await pocketbase.collection(_tagsCollectionName).getOne(id);
    return tagRecord.toRdbTag();
  }

  Future<String> createTag(RdbTag tag) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final data = tag.toRecordModel().toJson();
    final recordModel = await pocketbase.collection(_tagsCollectionName).create(body: data);
    return recordModel.id;
  }

  Future<String> updateTag(RdbTag tag) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final data = tag.toRecordModel().toJson();
    final recordModel = await pocketbase.collection(_tagsCollectionName).update(tag.id, body: data);
    return recordModel.id;
  }

  Future<void> deleteTag(RdbTag tag) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    await pocketbase.collection(_tagsCollectionName).delete(tag.id);
  }

  Future<List<RdbVocabulary>> getVocabularies({
    String? searchTerm,
    Tag? tag,
    String? userId,
  }) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final String? searchFilter = searchTerm != null ? "(source LIKE \"%$searchTerm%\" OR target LIKE \"%$searchTerm%\")" : null;
    final String? tagFilter = tag != null ? "tags LIKE \"%${tag.id}%\"" : null;
    final String? userFilter = userId != null ? "$_userFieldName=\"$userId\"" : null;
    final String filter = [userFilter, tagFilter, searchFilter].nonNulls.join(" AND ");

    return pocketbase.collection(_vocabulariesCollectionName).getFullList(filter: filter).then((value) async {
      return value.map((RecordModel record) => record.toRdbVocabulary()).toList();
    });
  }

  void subscribeToVocabularyChanges(Function(RdbEventType type, RdbVocabulary rdbVocabulary) onEvent, {String? userId}) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();

    // ? Unsubscribe from previous subscriptions
    // * (could lead to bugs, if different subscriptions with other topics are used)
    try {
      pocketbase.collection(_vocabulariesCollectionName).unsubscribe("*");
    } catch (e) {
      Log.error("Failed to unsubscribe from previous vocabulary subscriptions.", exception: e);
    }

    final String? userFilter = userId == null ? null : "$_userFieldName=\"$userId\"";

    pocketbase.collection(_vocabulariesCollectionName).subscribe("*", filter: userFilter, (RecordSubscriptionEvent event) {
      // TODO: Add user filter for vocabulary changes (.subscribe has a parameter for this)
      final eventType = switch (event.action) {
        "create" => RdbEventType.create,
        "update" => RdbEventType.update,
        "delete" => RdbEventType.delete,
        _ => null,
      };
      if (eventType == null) return;
      final vocabulary = event.record?.toRdbVocabulary();
      if (vocabulary != null) {
        onEvent(eventType, vocabulary);
      }
    });
  }

  Stream<List<RdbVocabulary>> getVocabularyStream({
    String? searchTerm,
    Tag? tag,
    String? userId,
  }) async* {
    final controller = StreamController<List<RdbVocabulary>>();

    yield await getVocabularies(searchTerm: searchTerm, tag: tag, userId: userId);

    final PocketBase pocketbase = await _connectionClient.getConnection();
    pocketbase.collection(_vocabulariesCollectionName).subscribe("*", (event) async {
      final vocabularies = await getVocabularies(searchTerm: searchTerm, tag: tag, userId: userId);
      controller.add(vocabularies);
    });

    yield* controller.stream;
  }

  Future<void> addVocabulary(RdbVocabulary vocabulary, {Uint8List? draftImageToUpload}) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final body = vocabulary.toRecordModel().toJson();
    Log.debug("raw vocabulary: $vocabulary, data: $body");
    if (draftImageToUpload == null) {
      await pocketbase.collection(_vocabulariesCollectionName).create(body: body);
    } else {
      await pocketbase.collection(_vocabulariesCollectionName).create(
        body: body,
        files: [
          MultipartFile.fromBytes(
            _customImageFieldName,
            draftImageToUpload,
          ),
        ],
      );
    }
  }

  Future<void> deleteAllVocabularies() async {
    // TODO: Implement deleteAllVocabularies for data source
    //final PocketBase pocketbase = await RemoteDatabaseDataSource.getConnection();
    //await pocketbase.collection(_vocabulariesCollectionName).delete();
  }

  Future<void> deleteVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    if (vocabulary.id == null) {
      throw const FormatException("updateVocabulary: RdbVocabulary id is null");
    }
    await pocketbase.collection(_vocabulariesCollectionName).delete(vocabulary.id!);
  }

  Future<void> updateVocabulary(RdbVocabulary vocabulary, {Uint8List? draftImageToUpload}) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final data = vocabulary.toRecordModel().toJson();
    if (vocabulary.id == null) {
      throw const FormatException("updateVocabulary: RdbVocabulary id is null");
    }
    if (draftImageToUpload == null) {
      await pocketbase.collection(_vocabulariesCollectionName).update(vocabulary.id!, body: data);
    } else {
      await pocketbase.collection(_vocabulariesCollectionName).update(
        vocabulary.id!,
        body: data,
        files: [
          MultipartFile.fromBytes(
            _customImageFieldName,
            draftImageToUpload,
          ),
        ],
      );
    }
  }
}
