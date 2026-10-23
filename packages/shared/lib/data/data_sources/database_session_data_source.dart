import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _localDatabaseName = "local.db";
const _localOwnerFileName = "local_owner_id";
const _userDatabasePrefix = "user_";
const _databaseExtension = ".db";
const _databaseFileSuffixes = ["", "-wal", "-shm"];
const _openTimeout = Duration(seconds: 20);

abstract class DatabaseSessionDataSource {
  OfflineSyncDatabaseSession? get currentSession;

  Stream<OfflineSyncDatabaseSession?> watchSession();

  Future<bool> hasLocalDatabase();

  Future<OfflineSyncDatabaseSession> openLocal();

  Future<OfflineSyncDatabaseSession> openForUser(UuidValue userId);

  Future<void> close();

  Future<void> deleteLocal();

  Future<void> deleteForUser(UuidValue userId);
}

@LazySingleton(as: DatabaseSessionDataSource)
class DatabaseSessionDataSourceImpl(
  final Client _client,
) implements DatabaseSessionDataSource {
  final _sessionChanges = StreamController<OfflineSyncDatabaseSession?>.broadcast();
  OfflineSyncDatabaseSession? _session;
  String? _sessionPath;

  @override
  OfflineSyncDatabaseSession? get currentSession => _session;

  @override
  Stream<OfflineSyncDatabaseSession?> watchSession() async* {
    yield _session;
    yield* _sessionChanges.stream;
  }

  @override
  Future<bool> hasLocalDatabase() async => File(await _localDatabasePath()).exists();

  @override
  Future<OfflineSyncDatabaseSession> openLocal() async {
    final ownerFile = File("${await _directoryPath()}/$_localOwnerFileName");
    if (!await ownerFile.exists()) {
      await ownerFile.writeAsString(const Uuid().v7obj().uuid);
    }
    final ownerId = UuidValue.withValidation((await ownerFile.readAsString()).trim());
    return _open(await _localDatabasePath(), ownerId);
  }

  @override
  Future<OfflineSyncDatabaseSession> openForUser(UuidValue userId) async {
    return _open(await _userDatabasePath(userId), userId);
  }

  @override
  Future<void> close() async {
    final session = _session;
    _session = null;
    _sessionPath = null;
    _sessionChanges.add(null);
    await session?.close();
  }

  @override
  Future<void> deleteLocal() async {
    await _delete(await _localDatabasePath());
    final ownerFile = File("${await _directoryPath()}/$_localOwnerFileName");
    if (await ownerFile.exists()) await ownerFile.delete();
  }

  @override
  Future<void> deleteForUser(UuidValue userId) async => _delete(await _userDatabasePath(userId));

  Future<OfflineSyncDatabaseSession> _open(String path, UuidValue ownerId) async {
    final current = _session;
    if (current != null && _sessionPath == path) return current;
    await close();
    final session = await _openSyncSession(path, ownerId);
    _session = session;
    _sessionPath = path;
    _sessionChanges.add(session);
    return session;
  }

  Future<OfflineSyncDatabaseSession> _openSyncSession(String path, UuidValue ownerId) async {
    try {
      return await _createSyncSession(path, ownerId);
    } on TimeoutException {
      final recoverySession = await _client.createSession(path).timeout(_openTimeout);
      await recoverySession.close();
      return _createSyncSession(path, ownerId);
    }
  }

  Future<OfflineSyncDatabaseSession> _createSyncSession(String path, UuidValue ownerId) {
    return _client
        .createSyncSession(path, isDebugMode: kDebugMode, persistentUserId: ownerId)
        .timeout(_openTimeout);
  }

  Future<void> _delete(String path) async {
    if (_sessionPath == path) await close();
    for (final suffix in _databaseFileSuffixes) {
      final file = File("$path$suffix");
      if (await file.exists()) await file.delete();
    }
  }

  Future<String> _directoryPath() async => (await getApplicationSupportDirectory()).path;

  Future<String> _localDatabasePath() async => "${await _directoryPath()}/$_localDatabaseName";

  Future<String> _userDatabasePath(UuidValue userId) async =>
      "${await _directoryPath()}/$_userDatabasePrefix${userId.uuid}$_databaseExtension";
}
