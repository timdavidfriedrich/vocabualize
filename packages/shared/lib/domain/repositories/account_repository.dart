import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/sign_in_result.dart';

abstract class AccountRepository {
  Stream<AppResult<AuthStatus>> watchAuthStatus();

  Future<AppResult<AuthStatus>> restoreAuthStatus();

  Future<AppResult<Account>> continueWithoutAccount();

  Future<AppResult<SignInResult>> signInWithGoogle();

  Future<AppResult<Account?>> resolveAccountConflict({required bool keepsPreviousAccount});

  Future<AppResult<()>> signOut({required bool discardUnsyncedChanges});
}
