import 'dart:math';
import 'package:vocabualize/constants/common_imports.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/log.dart';
import 'package:vocabualize/features/core/services/firebase/app_user.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/onboarding/widgets/password_reset_failed_dialog.dart';
import 'package:vocabualize/features/onboarding/widgets/sign_in_failed_dialog.dart';
import 'package:vocabualize/features/onboarding/widgets/sign_up_failed_dialog.dart';
import 'package:vocabualize/features/reports/services/report.dart';
import 'package:vocabualize/features/reports/services/translation_report.dart';

class FirebaseService {
  static final _usersDocument = FirebaseFirestore.instance.collection('users');
  static final _bugReportsDocument = FirebaseFirestore.instance.collection('bug_reports');
  static final _translationReportsDocument = FirebaseFirestore.instance.collection('translation_reports');

  get userDocument => _usersDocument;
  get bugReportsDocument => _bugReportsDocument;
  get translationReportsDocument => _translationReportsDocument;

  static Future<void> reloadUser() async {
    await FirebaseAuth.instance.currentUser!.reload();
  }

  static Future signInAnonymously() async {
    Messenger.loadingAnimation();
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (error) {
      Log.error(error);
    }
    Navigator.pop(Global.context);
  }

  static Future createUserWithEmailAndPassword(String email, String password) async {
    Messenger.loadingAnimation();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password);
      await sendVerificationEmail();
      Navigator.pop(Global.context);
    } on FirebaseAuthException catch (error) {
      Messenger.showAnimatedDialog(SignUpFailedDialog(error: error));
      Log.error(error);
    }
  }

  static Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (error) {
      Log.error(error);
    }
  }

  static Future signInWithEmailAndPassword(String email, String password) async {
    Messenger.loadingAnimation();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password);
      Navigator.pop(Global.context);
    } on FirebaseAuthException catch (error) {
      Messenger.showAnimatedDialog(SignInFailedDialog(error: error));
      Log.error(error);
    }
  }

  static Future signOut() async {
    Messenger.loadingAnimation();
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      Log.error(error);
    }
    Navigator.pop(Global.context);
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      Messenger.showAnimatedDialog(PasswordResetFailedDialog(error: error));
      Log.error(error);
    }
  }

  static Future createUser({required AppUser user}) async {
    await _usersDocument.doc().set(user.toJson());
  }

  static Future sendReport(Report report) async {
    int randomEnding = Random().nextInt(999999999) + 100000000;
    final document = report is TranslationReport ? _translationReportsDocument : _bugReportsDocument;
    await document.doc("${report.formattedDateDetailed}_$randomEnding").set(report.toJson());
  }
}
