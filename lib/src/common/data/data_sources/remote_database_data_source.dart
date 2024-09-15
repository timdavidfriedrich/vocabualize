import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/secrets/pocketbase_secrets.dart';
import 'package:vocabualize/src/common/data/mappers/report_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_bug_report.dart';
import 'package:vocabualize/src/common/data/models/rdb_translation_report.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class RemoteDatabaseDataSource {
  final String _vocabulariesCollectionName = "vocabularies";
  final String _languagesCollectionName = "languages";
  final String _tagsCollectionName = "tags_by_user";
  final String _translationReportCollectionName = "translation_reports";
  final String _bugReportCollectionName = "bug_reports";

  static PocketBase? _pocketBase;

  static Future<PocketBase> getConnection() async {
    FlutterSecureStorage? secureStorage = const FlutterSecureStorage();
    if (_pocketBase == null) {
      return _pocketBase = PocketBase(
        PocketbaseSecrets.databaseUrl,
        authStore: AsyncAuthStore(
          save: (String data) async => secureStorage.write(key: 'authStore', value: data),
          initial: await secureStorage.read(key: 'authStore'),
        ),
      );
    } else {
      return _pocketBase!;
    }
  }

  Future<List<Vocabulary>> _fetchData() async {
    List<Language> languages = await _fetchLanguages();
    List<Tag> tags = await _fetchTags();
    List<Vocabulary> vocabularies = await _fetchVocabularies(languages: languages, tags: tags);
    return vocabularies;
  }

  Future<List<Language>> _fetchLanguages() async {
    final PocketBase pocketbase = await getConnection();
    final languageRecords = await pocketbase.collection(_languagesCollectionName).getList();
    final test = languageRecords.items.map((e) => Language.fromRecord(e)).toList();
    return test;
  }

  Future<List<Tag>> _fetchTags() async {
    final PocketBase pocketbase = await getConnection();
    final String userFilter = "user=\"${AppUser.instance.id}\"";
    final tagsRecords = await pocketbase.collection(_tagsCollectionName).getList(filter: userFilter);
    final test = tagsRecords.items.map((e) => Tag.fromRecord(e)).toList();
    return test;
  }

  Future<List<Vocabulary>> _fetchVocabularies({List<Tag>? tags, List<Language>? languages}) async {
    final PocketBase pocketbase = await getConnection();
    final String userFilter = "user=\"${AppUser.instance.id}\"";
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

  Future<void> sendBugReport(RdbBugReport bugReport) async {
    final PocketBase pocketbase = await getConnection();
    await pocketbase.collection(_bugReportCollectionName).create(body: bugReport.toRecordModel().toJson());
  }

  Future<void> sendTranslationReport(RdbTranslationReport translationReport) async {
    final PocketBase pocketbase = await getConnection();
    await pocketbase.collection(_translationReportCollectionName).create(body: translationReport.toRecordModel().toJson());
  }

  /// ! NEW ///

  Future<List<RdbVocabulary>> getVocabularies({
    String? searchTerm,
    Tag? tag,
    String? userId,
  }) async {
    final PocketBase pocketbase = await getConnection();
    final String searchFilter = searchTerm != null ? "searchTerms contains \"$searchTerm\"" : "";
    final String tagFilter = tag != null ? "tags contains \"${tag.id}\"" : "";
    final String userFilter = userId != null ? "user=\"$userId\"" : "";
    final String filter = [userFilter, tagFilter, searchFilter].where((e) => e.isNotEmpty).join(" AND ");

    return pocketbase.collection(_vocabulariesCollectionName).getList(filter: filter).then((value) async {
      return value.items.map((RecordModel record) => record.toRdbVocabulary()).toList();
    });
  }

  Future<void> addVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await getConnection();
    final data = vocabulary.toRecordModel().toJson();
    await pocketbase.collection(_vocabulariesCollectionName).create(body: data);
  }

  Future<void> deleteAllVocabularies() async {
    // TODO: Implement deleteAllVocabularies
    //final PocketBase pocketbase = await RemoteDatabaseDataSource.getConnection();
    //await pocketbase.collection(_vocabulariesCollectionName).delete();
  }

  Future<void> deleteVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await getConnection();
    await pocketbase.collection(_vocabulariesCollectionName).delete(vocabulary.id);
  }

  Future<void> updateVocabulary(RdbVocabulary vocabulary) async {
    final PocketBase pocketbase = await getConnection();
    final data = vocabulary.toRecordModel().toJson();
    await pocketbase.collection(_vocabulariesCollectionName).update(vocabulary.id, body: data);
  }
}
