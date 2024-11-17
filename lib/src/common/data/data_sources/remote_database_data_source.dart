import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_connection_client.dart';
import 'package:vocabualize/src/common/data/mappers/auth_mappers.dart';
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
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';

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
  final String _customImageFieldName = "customImage";

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

  Future<List<RdbTag>> getTags() async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final userId = pocketbase.authStore.toAppUser()?.id;
    final String? userFilter = userId?.let((id) => "$_userFieldName=\"$id\"");
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
  }) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final String? searchFilter = searchTerm?.let((term) => "source LIKE \"%$term%\" OR target LIKE \"%$term%\"");
    final String? tagFilter = tag?.let((t) => "tags LIKE \"%${t.id}%\"");
    final String? userId = pocketbase.authStore.toAppUser()?.id;
    final String? userFilter = userId?.let((id) => "$_userFieldName=\"$id\"");
    final String filter = [userFilter, tagFilter, searchFilter].nonNulls.map((f) => "($f)").join(" AND ");

    return pocketbase.collection(_vocabulariesCollectionName).getFullList(filter: filter).then((value) async {
      return value.map((RecordModel record) => record.toRdbVocabulary()).toList();
    });
  }

  void subscribeToVocabularyChanges(Function(RdbEventType type, RdbVocabulary rdbVocabulary) onEvent) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();

    // ? Unsubscribe from previous subscriptions
    // * (could lead to bugs, if different subscriptions with other topics are used)
    try {
      pocketbase.collection(_vocabulariesCollectionName).unsubscribe("*");
    } catch (e) {
      Log.error("Failed to unsubscribe from previous vocabulary subscriptions.", exception: e);
    }

    final userId = pocketbase.authStore.toAppUser()?.id;
    final String? userFilter = userId?.let((id) => "$_userFieldName=\"$id\"");

    pocketbase.collection(_vocabulariesCollectionName).subscribe(
      "*",
      filter: userFilter,
      (RecordSubscriptionEvent event) {
        final eventType = switch (event.action) {
          "create" => RdbEventType.create,
          "update" => RdbEventType.update,
          "delete" => RdbEventType.delete,
          _ => null,
        };
        if (eventType == null) return;
        final vocabulary = event.record?.toRdbVocabulary();
        vocabulary?.let((v) {
          onEvent(eventType, v);
        });
      },
    );
  }

  Stream<List<RdbVocabulary>> getVocabularyStream({
    String? searchTerm,
    Tag? tag,
  }) async* {
    final controller = StreamController<List<RdbVocabulary>>();

    yield await getVocabularies(searchTerm: searchTerm, tag: tag);

    final PocketBase pocketbase = await _connectionClient.getConnection();
    pocketbase.collection(_vocabulariesCollectionName).subscribe("*", (event) async {
      final vocabularies = await getVocabularies(searchTerm: searchTerm, tag: tag);
      controller.add(vocabularies);
    });

    yield* controller.stream;
  }

  Future<void> addVocabulary(RdbVocabulary vocabulary, {Uint8List? draftImageToUpload}) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final userId = pocketbase.authStore.toAppUser()?.id;
    final vocabularyWithUser = vocabulary.copyWith(user: userId);
    final body = vocabularyWithUser.toRecordModel().toJson();
    if (draftImageToUpload == null) {
      await pocketbase.collection(_vocabulariesCollectionName).create(body: body);
    } else {
      await pocketbase.collection(_vocabulariesCollectionName).create(
        body: body,
        files: [
          MultipartFile.fromBytes(
            _customImageFieldName,
            draftImageToUpload,
            filename: "image.jpg",
          ),
        ],
      );
    }
  }

  Future<void> updateVocabulary(RdbVocabulary vocabulary, {Uint8List? draftImageToUpload}) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final userId = pocketbase.authStore.toAppUser()?.id;
    final vocabularyWithUser = vocabulary.copyWith(user: userId);
    final body = vocabularyWithUser.toRecordModel().toJson();
    vocabulary.id?.let((id) async {
      if (draftImageToUpload == null) {
        await pocketbase.collection(_vocabulariesCollectionName).update(id, body: body);
      } else {
        await pocketbase.collection(_vocabulariesCollectionName).update(
          id,
          body: body,
          files: [
            MultipartFile.fromBytes(
              _customImageFieldName,
              draftImageToUpload,
              filename: "image.jpg",
            ),
          ],
        );
      }
    });
  }

  Future<void> deleteVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await _connectionClient.getConnection();
    final userId = pocketbase.authStore.toAppUser()?.id;
    final vocabularyWithUser = vocabulary.copyWith(user: userId);
    vocabularyWithUser.id?.let((id) async {
      await pocketbase.collection(_vocabulariesCollectionName).delete(id);
    });
  }
}
