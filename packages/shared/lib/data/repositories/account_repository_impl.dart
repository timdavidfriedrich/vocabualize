import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/auth_data_source.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/local_import_data_source.dart';
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
  final LocalImportDataSource _importDataSource,
  final SyncDataSource _syncDataSource,
) implements AccountRepository {
  final _statusChanges = StreamController<AuthStatus>.broadcast();
  AuthStatus _status = const AuthUnknown();

  @override
  Stream<AppResult<AuthStatus>> watchAuthStatus() async* {
    yield Success(_status);
    yield* _statusChanges.stream.map<AppResult<AuthStatus>>(Success.new);
  }

  @override
  Future<AppResult<AuthStatus>> restoreAuthStatus() async {
    try {
      final remoteAccount = await _authDataSource.restoreAccount();
      if (remoteAccount != null) {
        await _openRemote(remoteAccount);
        unawaited(_refreshRemote());
      }
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
    final RemoteAccount remoteAccount;
    try {
      remoteAccount = await _authDataSource.signInWithGoogle();
    } on Object {
      return const Failure(AuthError());
    }
    try {
      return await _openRemote(remoteAccount);
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> signOut({required bool discardUnsyncedChanges}) async {
    if (_status case AuthAuthenticated(account: GoogleAccount(:final id))) {
      final session = _sessions.currentSession;
      await _syncDataSource.stop();
      if (!discardUnsyncedChanges && session != null) {
        try {
          await _syncDataSource.syncOnce(session);
        } on Object {
          _syncDataSource.start(session);
          return const Failure(SyncPendingError());
        }
      }
      try {
        await _authDataSource.signOut();
        await _sessions.deleteForUser(UuidValue.withValidation(id));
      } on Object catch (error) {
        return Failure(UnexpectedError(error.toString()));
      }
      _emit(const AuthUnauthenticated());
      return const Success(());
    }
    return const Failure(AuthError());
  }

  Future<Account> _openLocal() async {
    await _syncDataSource.stop();
    await _sessions.openLocal();
    const account = LocalAccount();
    _emit(const AuthAuthenticated(account: account));
    return account;
  }

  Future<AppResult<Account>> _openRemote(RemoteAccount remoteAccount) async {
    final session = await _sessions.openForUser(UuidValue.withValidation(remoteAccount.id));
    final adoption = await _adoptLocalData();
    _syncDataSource.start(session);
    final account = remoteAccount.toGoogleAccount();
    _emit(AuthAuthenticated(account: account));
    return switch (adoption) {
      Success() => Success(account),
      Failure(:final error) => Failure(error),
    };
  }

  Future<AppResult<()>> _adoptLocalData() async {
    try {
      final snapshot = await _sessions.readLocalSnapshot();
      if (snapshot == null) return const Success(());
      await _importDataSource.importSnapshot(snapshot);
      await _sessions.deleteLocal();
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  Future<void> _refreshRemote() async {
    try {
      final remoteAccount = await _authDataSource.refreshAccount();
      if (remoteAccount != null) _emit(AuthAuthenticated(account: remoteAccount.toGoogleAccount()));
    } on Object {
      return;
    }
  }

  void _emit(AuthStatus status) {
    _status = status;
    _statusChanges.add(status);
  }
}
