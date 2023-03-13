import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabualize/features/core/services/firebase/app_user.dart';
import 'package:vocabualize/features/reports/services/report.dart';
import 'package:vocabualize/features/reports/services/translation_report.dart';

class CloudService {
  static final _usersDocument = FirebaseFirestore.instance.collection('users');
  static final _bugReportsDocument = FirebaseFirestore.instance.collection('bug_reports');
  static final _translationReportsDocument = FirebaseFirestore.instance.collection('translation_reports');

  get userDocument => _usersDocument;
  get bugReportsDocument => _bugReportsDocument;
  get translationReportsDocument => _translationReportsDocument;

  static Future createUser({required AppUser user}) async {
    await _usersDocument.doc().set(user.toJson());
  }

  static Future sendReport(Report report) async {
    int randomEnding = Random().nextInt(999999999) + 100000000;
    final document = report is TranslationReport ? _translationReportsDocument : _bugReportsDocument;
    await document.doc("${report.formattedDateDetailed}_$randomEnding").set(report.toJson());
  }
}
