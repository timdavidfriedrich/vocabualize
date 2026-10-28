import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/auth_data_source.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/device_data_source.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/image_sync_data_source.dart';
import 'package:shared/data/data_sources/image_transfer_data_source.dart';
import 'package:shared/data/data_sources/local_import_data_source.dart';
import 'package:shared/data/data_sources/service_access_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/data_sources/space_storage_data_source.dart';
import 'package:shared/data/data_sources/sync_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/account_mappers.dart';
import 'package:shared/data/models/local_account_metadata.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:shared/data/models/remote_account.dart';
import 'package:shared/data/models/storage_space.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/domain/repositories/account_repository.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl(
  final AuthDataSource _authDataSource,
  final DatabaseSessionDataSource _sessions,
  final SpaceStorageDataSource _storage,
  final ImageFileDataSource _imageFiles,
  final ImageTransferDataSource _imageTransfer,
  final LocalImportDataSource _importDataSource,
  final SettingLocalDataSource _settingDataSource,
  final SyncDataSource _syncDataSource,
  final ImageSyncDataSource _imageSyncDataSource,
  final ServiceAccessDataSource _serviceAccessDataSource,
  final DeviceDataSource _deviceDataSource,
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
      await _storage.deleteMarkedSpaces();
      final remoteAccount = await _authDataSource.restoreAccount();
      if (remoteAccount != null) {
        await _openRemote(remoteAccount);
        unawaited(_refreshRemote());
      }
      if (remoteAccount == null && await _storage.hasDatabase(const LocalOnlySpace())) {
        await _openLocal();
      }
      if (_status is AuthUnknown) _emit(const AuthUnauthenticated());
      return Success(_status);
    } on Object catch (error) {
      _emit(const AuthUnauthenticated());
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<Account>> continueWithoutAccount() async {
    try {
      return Success(await _openLocal());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<SignInResult>> signInWithGoogle() async {
    final RemoteAccount? remoteAccount;
    try {
      remoteAccount = await _authDataSource.signInWithGoogle();
    } on Object {
      return const Failure(AuthError());
    }
    if (remoteAccount == null) return const Success(SignInCancelled());
    try {
      if (await _findOtherAccount(remoteAccount.id) case final previous?) {
        _pendingSignIn = remoteAccount;
        return Success(
          AccountConflict(
            previous: await _toGoogleAccount(previous),
            next: remoteAccount.toGoogleAccount(),
          ),
        );
      }
      final opened = await _openRemote(remoteAccount);
      unawaited(_updateProfilePicture(remoteAccount));
      return switch (opened) {
        Success(:final data) => Success(SignedIn(account: data)),
        Failure(:final error) => Failure(error),
      };
    } on Object catch (error) {
      return Failure(error.toAppError());
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
        await _removeSpace(AccountSpace(userId: UuidValue.withValidation(previous.accountId)));
      }
      final opened = await _openRemote(pendingSignIn);
      unawaited(_updateProfilePicture(pendingSignIn));
      return opened;
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> signOut({required bool discardUnsyncedChanges}) async {
    if (_status case AuthAuthenticated(account: GoogleAccount(:final id))) {
      final session = _sessions.currentSession;
      final userId = UuidValue.withValidation(id);
      final space = AccountSpace(userId: userId);
      await _stopSync();
      if (!discardUnsyncedChanges && session != null && !await _uploadPending(session)) {
        await _startSync(session, userId);
        return const Failure(SyncPendingError());
      }
      await _removeSignedOutSpace(space, signsOut: true);
      return const Success(());
    }
    return const Failure(AuthError());
  }

  @override
  Future<AppResult<()>> deleteAccount() async {
    switch (_status) {
      case AuthAuthenticated(account: GoogleAccount(:final id)):
        final userId = UuidValue.withValidation(id);
        final session = _sessions.currentSession;
        await _stopSync();
        try {
          await _authDataSource.deleteAccount();
        } on Object catch (error) {
          if (session != null) await _startSync(session, userId);
          return Failure(error.toAppError());
        }
        await _removeSignedOutSpace(AccountSpace(userId: userId), signsOut: true);
        await _forgetDevice();
        return const Success(());
      case AuthAuthenticated(account: LocalAccount()):
        await _removeSignedOutSpace(const LocalOnlySpace(), signsOut: false);
        await _forgetDevice();
        return const Success(());
      case AuthUnknown() || AuthUnauthenticated():
        return const Failure(AuthError());
    }
  }

  Future<void> _forgetDevice() async {
    await _attempt(_serviceAccessDataSource.forgetInstall);
    await _attempt(_deviceDataSource.deleteDeviceId);
  }

  Future<void> _removeSignedOutSpace(StorageSpace space, {required bool signsOut}) async {
    _emit(const AuthUnauthenticated());
    await _attempt(() => _closeIfOpen(space));
    await _attempt(() => _storage.markForDeletion(space));
    if (signsOut) await _attempt(_authDataSource.signOut);
    await _attempt(_storage.deleteMarkedSpaces);
  }

  Future<Account> _openLocal() async {
    await _stopSync();
    await _sessions.open(const LocalOnlySpace());
    const account = LocalAccount();
    _emit(const AuthAuthenticated(account: account));
    return account;
  }

  Future<AppResult<Account>> _openRemote(RemoteAccount remoteAccount) async {
    final userId = UuidValue.withValidation(remoteAccount.id);
    final session = await _sessions.open(AccountSpace(userId: userId));
    final metadata = await _rememberAccount(remoteAccount);
    final adoption = await _adoptLocalData(userId);
    await _startSync(session, userId);
    final account = await _toGoogleAccount(metadata);
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
      needsInitialSync: !await _storage.hasCompletedInitialSync(userId),
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
      const localSpace = LocalOnlySpace();
      final snapshot = await _sessions.readSnapshot(localSpace);
      final localOwnerId = await _storage.readLocalOwnerId();
      if (snapshot == null || localOwnerId == null) return const Success(());
      await _imageFiles.moveImages(
        from: localSpace,
        to: AccountSpace(userId: userId),
      );
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
      await _removeSpace(localSpace);
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  Future<void> _refreshRemote() async {
    try {
      final remoteAccount = await _authDataSource.refreshAccount();
      if (remoteAccount == null) return;
      final metadata = await _rememberAccount(remoteAccount);
      _emit(AuthAuthenticated(account: await _toGoogleAccount(metadata)));
      await _updateProfilePicture(remoteAccount);
    } on Object {
      return;
    }
  }

  Future<LocalAccountMetadata> _rememberAccount(RemoteAccount remoteAccount) async {
    final stored = await _storage.readAccount(UuidValue.withValidation(remoteAccount.id));
    final metadata = remoteAccount.toLocalAccountMetadata(stored: stored);
    await _storage.writeAccount(metadata);
    return metadata;
  }

  Future<void> _updateProfilePicture(RemoteAccount remoteAccount) async {
    try {
      final userId = UuidValue.withValidation(remoteAccount.id);
      final stored = await _storage.readAccount(userId);
      if (stored == null || await _hasCurrentPicture(stored, remoteAccount.pictureUrl)) return;
      final pictureFileName = switch (remoteAccount.pictureUrl) {
        final pictureUrl? => await _storage.writeProfilePicture(
          userId,
          await _imageTransfer.download(pictureUrl),
        ),
        null => null,
      };
      final latest = await _storage.readAccount(userId);
      if (latest == null) return;
      final metadata = latest.copyWith(
        pictureUrl: remoteAccount.pictureUrl,
        pictureFileName: pictureFileName,
      );
      await _storage.writeAccount(metadata);
      if (latest.pictureFileName case final previousFileName?) {
        await _storage.deleteProfilePicture(userId, previousFileName);
      }
      if (_status case AuthAuthenticated(account: GoogleAccount(:final id))
          when id == userId.uuid) {
        _emit(AuthAuthenticated(account: await _toGoogleAccount(metadata)));
      }
    } on Object {
      return;
    }
  }

  Future<bool> _hasCurrentPicture(LocalAccountMetadata stored, String? pictureUrl) async {
    if (pictureUrl != stored.pictureUrl) return false;
    return pictureUrl == null || await _storage.findProfilePicture(stored) != null;
  }

  Future<GoogleAccount> _toGoogleAccount(LocalAccountMetadata metadata) async =>
      metadata.toGoogleAccount(picturePath: await _storage.findProfilePicture(metadata));

  Future<LocalAccountMetadata?> _findOtherAccount(String accountId) async {
    for (final account in await _storage.findAccounts()) {
      if (account.accountId != accountId) return account;
    }
    return null;
  }

  Future<void> _removeSpace(StorageSpace space) async {
    await _closeIfOpen(space);
    await _storage.markForDeletion(space);
    await _storage.deleteMarkedSpaces();
  }

  Future<void> _closeIfOpen(StorageSpace space) async {
    if (_sessions.currentSpace != space) return;
    await _stopSync();
    await _sessions.close();
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
