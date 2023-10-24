import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/core/models/pocketbase_model.dart';
import 'package:vocabualize/features/core/models/tag.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/reports/models/report.dart';
import 'package:vocabualize/features/reports/models/translation_report.dart';

class CloudService {
  static CloudService instance = CloudService();

  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _bugReportCollection = FirebaseFirestore.instance.collection('bug_reports');
  final _translationReportCollection = FirebaseFirestore.instance.collection('translation_reports');

// ! BEGIN OF NEW CODE
  final PocketBase _pocketbase = PocketBase('http://132.145.228.50:8090');
  final String _username = "friedrich.apptester@gmail.com";
  final String _password = "test123test";
  final String _usersCollectionName = "users";
  final String _vocabulariesCollectionName = "vocabularies";
  final String _languagesCollectionName = "languages";
  final String _tagsCollectionName = "tags_by_user";
  RecordAuth? _authData;

  final StreamController<List<Vocabulary>> _vocabularyStreamController = StreamController<List<Vocabulary>>.broadcast();
  Stream<List<Vocabulary>> get vocabularyBroadcastStream => _vocabularyStreamController.stream.asBroadcastStream();
  void cancelVocabularyStream() => _vocabularyStreamController.close();

  Future<bool> init() async {
    try {
      await _authorize();
      await _reloadData();
      await _subscribeToVocabularyChanges();
      return true;
    } catch (e) {
      Log.error("Could not initialize CloudService: $e");
      return false;
    }
  }

  Future<bool> _authorize() async {
    try {
      _authData = await _pocketbase.collection(_usersCollectionName).authWithPassword(_username, _password);
      return true;
    } catch (e) {
      Log.error("Could not authorize CloudService: $e");
      return false;
    }
  }

  Future<void> _subscribeToVocabularyChanges() async {
    _pocketbase.collection(_vocabulariesCollectionName).subscribe("*", (event) async {
      if (event.record?.data["user"] != _authData?.record?.id) return;
      await _reloadData();
      // TODO: Only fetch the changed vocabulary
      Log.hint("Vocabulary cloud data changed (id: ${event.record?.id ?? "unknown"}).");
    });
  }

  Future<void> _reloadData() async {
    List<Vocabulary> vocabularies = await _fetchData();
    _vocabularyStreamController.sink.add(vocabularies);
    Provider.of<VocabularyProvider>(Global.context, listen: false).vocabularyList = vocabularies;
  }

  Future<List<Vocabulary>> _fetchData() async {
    List<Language> languages = await _fetchLanguages();
    List<Tag> tags = await _fetchTags();
    List<Vocabulary> vocabularies = await _fetchVocabularies(languages: languages, tags: tags);
    return vocabularies;
  }

  Future<List<Language>> _fetchLanguages() async {
    final languageRecords = await _pocketbase.collection(_languagesCollectionName).getList();
    return languageRecords.items.map((e) => Language.fromJson(PocketBaseModel.fromRecordModel(e).data)).toList();
  }

  Future<List<Tag>> _fetchTags() async {
    final String userFilter = "user=\"${_authData?.record?.id}\"";
    final tagsRecords = await _pocketbase.collection(_tagsCollectionName).getList(filter: userFilter);
    return tagsRecords.items.map((e) => Tag.fromJson(PocketBaseModel.fromRecordModel(e).data)).toList();
  }

  Future<List<Vocabulary>> _fetchVocabularies({List<Tag>? tags, List<Language>? languages}) async {
    final String userFilter = "user=\"${_authData?.record?.id}\"";
    final vocabularyRecords = await _pocketbase.collection(_vocabulariesCollectionName).getList(filter: userFilter);
    final vocabularyRecords2 = await _pocketbase.collection("vocs").getList(filter: userFilter);
    Log.warning(vocabularyRecords.items);
    Log.error(vocabularyRecords2.items.map((e) => e.data).toList());
    return vocabularyRecords.items
        .map((e) => Vocabulary.fromJson(
              PocketBaseModel.fromRecordModel(e).data,
              tags: tags?.where((element) => (e.data["tags"]).contains(element.id)).toList(),
              languages: languages,
            ))
        .toList();
  }
// ! END OF NEW CODE

  Future saveUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final AppUser appUser = AppUser.instance;

    await _userCollection.doc(user!.uid).set(appUser.toJson(), SetOptions(merge: true));
    Log.warning("User data saved (UID: ${user.uid}).");
  }

  Future loadUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final AppUser appUser = AppUser.instance;

    DocumentSnapshot snapshot = await _userCollection.doc(user!.uid).get();

    if (!snapshot.exists) {
      appUser.signOut();
      saveUserData();
      return;
    }

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    appUser.loadFromJson(data);
    Log.warning("User data loaded (UID: ${user.uid}).");
  }

  Future sendReport(Report report) async {
    // TODO: Replace random ending with uuid and save creation date in report
    int randomEnding = Random().nextInt(999999999) + 100000000;
    final document = report is TranslationReport ? _translationReportCollection : _bugReportCollection;
    await document.doc("${report.formattedDateDetailed}_$randomEnding").set(report.toJson());
  }
}
