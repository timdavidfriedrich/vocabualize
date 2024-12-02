import 'package:vocabualize/src/common/domain/entities/app_user.dart';

abstract interface class AuthenticationRepository {
  Stream<AppUser?> getCurrentUser();
  Future<bool> createUserWithEmailAndPassword(String email, String password);
  Future<bool> signInWithEmailAndPasswort(String email, String password);
  Future<bool> signOut();
  Future<void> sendVerificationEmail();
  Future<void> sendPasswordResetEmail(String email);
}
