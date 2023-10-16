import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/log.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/reports/models/report.dart';
import 'package:vocabualize/features/reports/models/translation_report.dart';

class CloudService {
  final pocketbase = PocketBase('http://132.145.228.50:8090');

  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _bugReportCollection = FirebaseFirestore.instance.collection('bug_reports');
  final _translationReportCollection = FirebaseFirestore.instance.collection('translation_reports');

  static CloudService instance = CloudService();

  Future saveUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final AppUser appUser = AppUser.instance;

    await _userCollection.doc(user!.uid).set(appUser.toJson(), SetOptions(merge: true));
    Log.warning("User data saved (UID: ${user.uid}).");
  }

  // ! NEW LINES START
  Future loadData() async {
    final authData = await pocketbase.admins.authWithPassword('test@test.de', 'test123test');
    final vocabularyRecords = await pocketbase
        // query all vocabularies
        .collection('vocabularies')
        .getFullList(sort: '-created', expand: "sourceLanguage,targetLanguage,tags");
    Log.warning(vocabularyRecords);
    if (vocabularyRecords.isEmpty) return;

    Provider.of<VocabularyProvider>(Global.context, listen: false).clear();
    for (RecordModel voc in vocabularyRecords) {
      Provider.of<VocabularyProvider>(Global.context, listen: false).add(Vocabulary.fromJson(voc.data));
    }
  }
  // ! NEW LINES END

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
    int randomEnding = Random().nextInt(999999999) + 100000000;
    final document = report is TranslationReport ? _translationReportCollection : _bugReportCollection;
    await document.doc("${report.formattedDateDetailed}_$randomEnding").set(report.toJson());
  }
}
