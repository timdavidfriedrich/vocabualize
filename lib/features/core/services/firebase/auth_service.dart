import 'package:vocabualize/constants/common_imports.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/log.dart';
import 'package:vocabualize/features/core/services/firebase/app_user.dart';
import 'package:vocabualize/features/core/services/firebase/cloud_service.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/onboarding/widgets/password_reset_failed_dialog.dart';
import 'package:vocabualize/features/onboarding/widgets/sign_in_failed_dialog.dart';
import 'package:vocabualize/features/onboarding/widgets/sign_up_failed_dialog.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final User? user = FirebaseAuth.instance.currentUser;

  static Future<void> reloadUser() async {
    await user!.reload();
  }

  static Future signInAnonymously() async {
    Messenger.loadingAnimation();
    try {
      await _firebaseAuth.signInAnonymously();
    } catch (error) {
      Log.error(error);
    }
    Navigator.pop(Global.context);
  }

  static Future createUserWithEmailAndPassword(String email, String password) async {
    Messenger.loadingAnimation();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      await sendVerificationEmail();
      Navigator.pop(Global.context);
    } on FirebaseAuthException catch (error) {
      Messenger.showAnimatedDialog(SignUpFailedDialog(error: error));
      Log.error(error);
    }
  }

  static Future sendVerificationEmail() async {
    try {
      await user!.sendEmailVerification();
    } catch (error) {
      Log.error(error);
    }
  }

  static Future signInWithEmailAndPassword(String email, String password) async {
    Messenger.loadingAnimation();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password);
      await CloudService.loadUserData();
      Navigator.pop(Global.context);
    } on FirebaseAuthException catch (error) {
      Messenger.showAnimatedDialog(SignInFailedDialog(error: error));
      Log.error(error);
    }
  }

  static Future signOut() async {
    Messenger.loadingAnimation();
    try {
      await _firebaseAuth.signOut();
      await AppUser.instance.signOut();
    } catch (error) {
      Log.error(error);
    }
    Navigator.pop(Global.context);
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      Messenger.showAnimatedDialog(PasswordResetFailedDialog(error: error));
      Log.error(error);
    }
  }
}
