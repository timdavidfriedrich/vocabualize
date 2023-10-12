import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/log.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/reports/models/report.dart';
import 'package:vocabualize/features/reports/models/translation_report.dart';

class CloudService {
  static final _userCollection = FirebaseFirestore.instance.collection('users');
  static final _bugReportCollection = FirebaseFirestore.instance.collection('bug_reports');
  static final _translationReportCollection = FirebaseFirestore.instance.collection('translation_reports');

  static Future saveUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final AppUser appUser = AppUser.instance;

    await _userCollection.doc(user!.uid).set(appUser.toJson(), SetOptions(merge: true));
    Log.warning("User data saved (UID: ${user.uid}).");
  }

  static Future loadUserData() async {
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

  static Future sendReport(Report report) async {
    int randomEnding = Random().nextInt(999999999) + 100000000;
    final document = report is TranslationReport ? _translationReportCollection : _bugReportCollection;
    await document.doc("${report.formattedDateDetailed}_$randomEnding").set(report.toJson());
  }
}
