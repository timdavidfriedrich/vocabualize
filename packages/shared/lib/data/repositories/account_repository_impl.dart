import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/auth_data_source.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/sync_data_source.dart';
import 'package:shared/data/mappers/account_mappers.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl(
  final AuthDataSource _authDataSource,
  final DatabaseSessionDataSource _sessions,
  final SyncDataSource _syncDataSource,
) implements AccountRepository {
  final _statusChanges = StreamController<AuthStatus>.broadcast();
  AuthStatus _status = const AuthUnknown();

  @override
  Stream<AuthStatus> watchAuthStatus() async* {
    yield _status;
    yield* _statusChanges.stream;
  }

  @override
  Future<AppResult<AuthStatus>> restoreAuthStatus() async {
    try {
      final remoteAccount = await _authDataSource.restoreAccount();
      if (remoteAccount != null) await _openRemote(remoteAccount);
      if (remoteAccount == null && await _sessions.hasLocalDatabase()) await _openLocal();
      if (_status is AuthUnknown) _emit(const AuthUnauthenticated());
      return Success(_status);
    } on Object catch (error) {
      _emit(const AuthUnauthenticated());
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<Account>> continueWithoutAccount() async {
    try {
      return Success(await _openLocal());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<Account>> signInWithGoogle() async {
    try {
      final remoteAccount = await _authDataSource.signInWithGoogle();
      return Success(await _openRemote(remoteAccount));
    } on Object {
      return const Failure(AuthError());
    }
  }

  Future<Account> _openLocal() async {
    await _syncDataSource.stop();
    await _sessions.openLocal();
    const account = LocalAccount();
    _emit(const AuthAuthenticated(account: account));
    return account;
  }

  Future<Account> _openRemote(RemoteAccount remoteAccount) async {
    final session = await _sessions.openForUser(UuidValue.withValidation(remoteAccount.id));
    _syncDataSource.start(session);
    final account = remoteAccount.toGoogleAccount();
    _emit(AuthAuthenticated(account: account));
    return account;
  }

  void _emit(AuthStatus status) {
    _status = status;
    _statusChanges.add(status);
  }
}
