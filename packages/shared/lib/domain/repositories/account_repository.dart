import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';

abstract class AccountRepository {
  Stream<AppResult<AuthStatus>> watchAuthStatus();

  Future<AppResult<AuthStatus>> restoreAuthStatus();

  Future<AppResult<Account>> continueWithoutAccount();

  Future<AppResult<Account>> signInWithGoogle();

  Future<AppResult<()>> signOut({required bool discardUnsyncedChanges});
}
