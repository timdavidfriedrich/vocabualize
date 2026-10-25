import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/auth_data_source.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/image_sync_data_source.dart';
import 'package:shared/data/data_sources/local_import_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/data_sources/sync_data_source.dart';
import 'package:shared/data/mappers/account_mappers.dart';
import 'package:shared/data/models/local_account_metadata.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/domain/repositories/account_repository.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl(
  final AuthDataSource _authDataSource,
  final DatabaseSessionDataSource _sessions,
  final LocalImportDataSource _importDataSource,
  final SettingLocalDataSource _settingDataSource,
  final SyncDataSource _syncDataSource,
  final ImageSyncDataSource _imageSyncDataSource,
) implements AccountRepository {
  final _statusChanges = StreamController<AuthStatus>.broadcast();
  AuthStatus _status = const AuthUnknown();
  RemoteAccount? _pendingSignIn;

  @override
  Stream<AppResult<AuthStatus>> watchAuthStatus() async* {
    yield Success(_status);
    yield* _statusChanges.stream.map<AppResult<AuthStatus>>(Success.new);
  }

  @override
  Future<AppResult<AuthStatus>> restoreAuthStatus() async {
    try {
      await _sessions.deleteSignedOutAccounts();
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
  Future<AppResult<SignInResult>> signInWithGoogle() async {
    final RemoteAccount remoteAccount;
    try {
      remoteAccount = await _authDataSource.signInWithGoogle();
    } on Object {
      return const Failure(AuthError());
    }
    try {
      if (await _findOtherAccount(remoteAccount.id) case final previous?) {
        _pendingSignIn = remoteAccount;
        return Success(
          AccountConflict(
            previous: previous.toGoogleAccount(),
            next: remoteAccount.toGoogleAccount(),
          ),
        );
      }
      return switch (await _openRemote(remoteAccount)) {
        Success(:final data) => Success(SignedIn(account: data)),
        Failure(:final error) => Failure(error),
      };
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<Account?>> resolveAccountConflict({
    required bool keepsPreviousAccount,
  }) async {
    final pendingSignIn = _pendingSignIn;
    _pendingSignIn = null;
    if (pendingSignIn == null) return const Failure(AuthError());
    try {
      if (keepsPreviousAccount) {
        await _authDataSource.signOut();
        return const Success(null);
      }
      if (await _findOtherAccount(pendingSignIn.id) case final previous?) {
        await _deleteAccountData(UuidValue.withValidation(previous.accountId));
      }
      return await _openRemote(pendingSignIn);
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> signOut({required bool discardUnsyncedChanges}) async {
    if (_status case AuthAuthenticated(account: GoogleAccount(:final id))) {
      final session = _sessions.currentSession;
      await _stopSync();
      final userId = UuidValue.withValidation(id);
      if (!discardUnsyncedChanges && session != null && !await _uploadPending(session)) {
        await _startSync(session, userId);
        return const Failure(SyncPendingError());
      }
      await _attempt(() => _markSignedOut(userId));
      await _attempt(_authDataSource.signOut);
      await _attempt(() => _sessions.deleteForUser(userId));
      _emit(const AuthUnauthenticated());
      return const Success(());
    }
    return const Failure(AuthError());
  }

  Future<Account> _openLocal() async {
    await _stopSync();
    await _sessions.openLocal();
    const account = LocalAccount();
    _emit(const AuthAuthenticated(account: account));
    return account;
  }

  Future<AppResult<Account>> _openRemote(RemoteAccount remoteAccount) async {
    final userId = UuidValue.withValidation(remoteAccount.id);
    final session = await _sessions.openForUser(userId);
    await _rememberAccount(remoteAccount);
    final adoption = await _adoptLocalData(userId);
    await _startSync(session, userId);
    final account = remoteAccount.toGoogleAccount();
    _emit(AuthAuthenticated(account: account));
    return switch (adoption) {
      Success() => Success(account),
      Failure(:final error) => Failure(error),
    };
  }

  Future<void> _startSync(OfflineSyncDatabaseSession session, UuidValue userId) async {
    _syncDataSource.start(
      session,
      userId: userId,
      needsInitialSync: !await _sessions.hasCompletedInitialSync(userId),
    );
    _imageSyncDataSource.start(session);
  }

  Future<bool> _uploadPending(OfflineSyncDatabaseSession session) async {
    if (!await _imageSyncDataSource.uploadPending(session)) return false;
    try {
      await _syncDataSource.syncOnce(session);
      return true;
    } on Object {
      return false;
    }
  }

  Future<void> _stopSync() async {
    await _imageSyncDataSource.stop();
    await _syncDataSource.stop();
  }

  Future<AppResult<()>> _adoptLocalData(UuidValue userId) async {
    try {
      final snapshot = await _sessions.readLocalSnapshot();
      final localOwnerId = await _sessions.readLocalOwnerId();
      if (snapshot == null || localOwnerId == null) return const Success(());
      await _sessions.moveLocalImagesTo(userId);
      if (!await _settingDataSource.hasAdoptionRecord(localOwnerId)) {
        await _importDataSource.importSnapshot(
          LocalSnapshot(
            vocabularies: snapshot.vocabularies,
            tags: snapshot.tags,
            vocabularyTags: snapshot.vocabularyTags,
            activities: snapshot.activities,
            settings: [
              ...snapshot.settings,
              _settingDataSource.createAdoptionRecord(
                localOwnerId: localOwnerId,
                adoptedAt: DateTime.now(),
              ),
            ],
          ),
        );
      }
      await _sessions.deleteLocal();
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  Future<void> _refreshRemote() async {
    try {
      final remoteAccount = await _authDataSource.refreshAccount();
      if (remoteAccount == null) return;
      await _rememberAccount(remoteAccount);
      _emit(AuthAuthenticated(account: remoteAccount.toGoogleAccount()));
    } on Object {
      return;
    }
  }

  Future<void> _rememberAccount(RemoteAccount remoteAccount) async {
    final stored = await _sessions.readAccountMetadata(UuidValue.withValidation(remoteAccount.id));
    await _sessions.writeAccountMetadata(remoteAccount.toLocalAccountMetadata(stored: stored));
  }

  Future<void> _markSignedOut(UuidValue userId) async {
    final stored = await _sessions.readAccountMetadata(userId);
    final metadata =
        stored ??
        LocalAccountMetadata(
          accountId: userId.uuid,
          name: null,
          email: null,
          hasCompletedInitialSync: false,
          isSignedOut: false,
        );
    await _sessions.writeAccountMetadata(metadata.copyWith(isSignedOut: true));
  }

  Future<LocalAccountMetadata?> _findOtherAccount(String accountId) async {
    for (final account in await _sessions.findAccountsOnDevice()) {
      if (account.accountId != accountId && !account.isSignedOut) return account;
    }
    return null;
  }

  Future<void> _deleteAccountData(UuidValue userId) async {
    if (_status case AuthAuthenticated(account: GoogleAccount(:final id)) when id == userId.uuid) {
      await _stopSync();
    }
    await _sessions.deleteForUser(userId);
  }

  Future<void> _attempt(Future<void> Function() step) async {
    try {
      await step();
    } on Object {
      return;
    }
  }

  void _emit(AuthStatus status) {
    _status = status;
    _statusChanges.add(status);
  }
}
