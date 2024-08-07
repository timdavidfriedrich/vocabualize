import 'dart:async';

import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/core/models/tag.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/pocketbase_connection.dart';
import 'package:vocabualize/features/reports/models/report.dart';
import 'package:vocabualize/features/reports/models/translation_report.dart';

class CloudService {
  static CloudService instance = CloudService();

  final String _vocabulariesCollectionName = "vocabularies";
  final String _languagesCollectionName = "languages";
  final String _tagsCollectionName = "tags_by_user";
  final String _translationReportCollectionName = "translation_reports";
  final String _bugReportCollectionName = "bug_reports";

  StreamController<List<Vocabulary>> _streamController = StreamController<List<Vocabulary>>.broadcast();
  Stream<List<Vocabulary>> get stream => _streamController.stream.asBroadcastStream();

  void dispose() {
    _streamController.close();
  }

  CloudService() {
    _init();
  }

  Future<bool> _init() async {
    try {
      await _subscribeToVocabularyChanges();
      Log.hint("CloudService initialized");
      return true;
    } catch (e) {
      Log.error("Failed to initialize CloudService.", exception: e);
      return false;
    }
  }

  Future<void> _subscribeToVocabularyChanges() async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
    pocketbase.collection(_vocabulariesCollectionName).subscribe("*", (event) async {
      if (event.record?.data["user"] != AppUser.instance.id) return;
      await loadData();
      // TODO: Only fetch the changed vocabulary
      Log.hint("Vocabulary cloud data changed (id: ${event.record?.id ?? "unknown"}).");
    });
  }

  Future<void> loadData() async {
    List<Vocabulary> vocabularies = await _fetchData();
    if (_streamController.isClosed) {
      _streamController = StreamController<List<Vocabulary>>.broadcast();
      Log.error("Attempted to add data to a closed StreamController. Controller reinitialized.");
    }
    _streamController.add(vocabularies);
    Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList = vocabularies;
  }

  Future<List<Vocabulary>> _fetchData() async {
    List<Language> languages = await _fetchLanguages();
    List<Tag> tags = await _fetchTags();
    List<Vocabulary> vocabularies = await _fetchVocabularies(languages: languages, tags: tags);
    return vocabularies;
  }

  Future<List<Language>> _fetchLanguages() async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
    final languageRecords = await pocketbase.collection(_languagesCollectionName).getList();
    final test = languageRecords.items.map((e) => Language.fromRecord(e)).toList();
    return test;
  }

  Future<List<Tag>> _fetchTags() async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
    final String userFilter = "user=\"${AppUser.instance.id}\"";
    final tagsRecords = await pocketbase.collection(_tagsCollectionName).getList(filter: userFilter);
    final test = tagsRecords.items.map((e) => Tag.fromRecord(e)).toList();
    return test;
  }

  Future<List<Vocabulary>> _fetchVocabularies({List<Tag>? tags, List<Language>? languages}) async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
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

  Future saveUserData() async {
    // final User? user = FirebaseAuth.instance.currentUser;
    // final AppUser appUser = AppUser.instance;

    // await _userCollection.doc(user!.uid).set(appUser.toJson(), SetOptions(merge: true));
    // Log.warning("User data saved (UID: ${user.uid}).");
  }

  Future sendReport(Report report) async {
    final PocketBase pocketbase = await PocketbaseConnection.connect();
    final collectionName = report is TranslationReport ? _translationReportCollectionName : _bugReportCollectionName;
    await pocketbase.collection(collectionName).create(body: report.toJson());
  }
}
