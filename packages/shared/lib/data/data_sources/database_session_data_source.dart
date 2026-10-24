import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _localDatabaseName = "local.db";
const _localOwnerFileName = "local_owner_id";
const _userDatabasePrefix = "user_";
const _databaseExtension = ".db";
const _databaseFileSuffixes = ["", "-wal", "-shm"];
const _imagesDirectoryName = "images";
const _localImagesDirectoryName = "local";

abstract class DatabaseSessionDataSource {
  OfflineSyncDatabaseSession? get currentSession;

  Stream<OfflineSyncDatabaseSession?> watchSession();

  Future<bool> hasLocalDatabase();

  Future<LocalSnapshot?> readLocalSnapshot();

  Future<OfflineSyncDatabaseSession> openLocal();

  Future<OfflineSyncDatabaseSession> openForUser(UuidValue userId);

  Future<void> close();

  Future<void> deleteLocal();

  Future<void> deleteForUser(UuidValue userId);

  String? get currentImageDirectoryPath;

  Future<void> moveLocalImagesTo(UuidValue userId);
}

@LazySingleton(as: DatabaseSessionDataSource)
class DatabaseSessionDataSourceImpl(
  final Client _client,
) implements DatabaseSessionDataSource {
  final _sessionChanges = StreamController<OfflineSyncDatabaseSession?>.broadcast();
  OfflineSyncDatabaseSession? _session;
  String? _sessionPath;
  String? _imageDirectoryPath;

  @override
  OfflineSyncDatabaseSession? get currentSession => _session;

  @override
  String? get currentImageDirectoryPath => _imageDirectoryPath;

  @override
  Stream<OfflineSyncDatabaseSession?> watchSession() async* {
    yield _session;
    yield* _sessionChanges.stream;
  }

  @override
  Future<bool> hasLocalDatabase() async => File(await _localDatabasePath()).exists();

  @override
  Future<LocalSnapshot?> readLocalSnapshot() async {
    final path = await _localDatabasePath();
    final ownerId = await _readLocalOwnerId();
    if (ownerId == null || !await File(path).exists()) return null;
    final current = _session;
    final isLocalOpen = current != null && _sessionPath == path;
    final session = isLocalOpen
        ? current
        : await _client.createSyncSession(path, isDebugMode: kDebugMode, persistentUserId: ownerId);
    try {
      return LocalSnapshot(
        vocabularies: await LocalVocabulary.db.find(session),
        tags: await LocalTag.db.find(session),
        vocabularyTags: await LocalVocabularyTag.db.find(session),
        activities: await LocalActivity.db.find(session),
      );
    } finally {
      if (!isLocalOpen) await session.close();
    }
  }

  @override
  Future<OfflineSyncDatabaseSession> openLocal() async {
    final ownerId = await _readLocalOwnerId() ?? await _createLocalOwnerId();
    return _open(await _localDatabasePath(), ownerId, _localImagesDirectoryName);
  }

  @override
  Future<OfflineSyncDatabaseSession> openForUser(UuidValue userId) async {
    return _open(await _userDatabasePath(userId), userId, userId.uuid);
  }

  @override
  Future<void> close() async {
    final session = _session;
    _session = null;
    _sessionPath = null;
    _imageDirectoryPath = null;
    _sessionChanges.add(null);
    await session?.close();
  }

  @override
  Future<void> deleteLocal() async {
    await _delete(await _localDatabasePath());
    await _deleteDirectory(await _imageDirectory(_localImagesDirectoryName));
    final ownerFile = File("${await _directoryPath()}/$_localOwnerFileName");
    if (await ownerFile.exists()) await ownerFile.delete();
  }

  @override
  Future<void> deleteForUser(UuidValue userId) async {
    await _delete(await _userDatabasePath(userId));
    await _deleteDirectory(await _imageDirectory(userId.uuid));
  }

  @override
  Future<void> moveLocalImagesTo(UuidValue userId) async {
    final source = await _imageDirectory(_localImagesDirectoryName);
    if (!await source.exists()) return;
    final target = await _imageDirectory(userId.uuid);
    await target.create(recursive: true);
    await for (final entity in source.list()) {
      if (entity is File) await entity.rename("${target.path}/${entity.uri.pathSegments.last}");
    }
  }

  Future<OfflineSyncDatabaseSession> _open(
    String path,
    UuidValue ownerId,
    String imageDirectoryName,
  ) async {
    final current = _session;
    if (current != null && _sessionPath == path) return current;
    await close();
    final imageDirectory = await _imageDirectory(imageDirectoryName);
    await imageDirectory.create(recursive: true);
    final session = await _client.createSyncSession(
      path,
      isDebugMode: kDebugMode,
      persistentUserId: ownerId,
    );
    _session = session;
    _sessionPath = path;
    _imageDirectoryPath = imageDirectory.path;
    _sessionChanges.add(session);
    return session;
  }

  Future<void> _delete(String path) async {
    if (_sessionPath == path) await close();
    for (final suffix in _databaseFileSuffixes) {
      final file = File("$path$suffix");
      if (await file.exists()) await file.delete();
    }
  }

  Future<Directory> _imageDirectory(String name) async =>
      Directory("${await _directoryPath()}/$_imagesDirectoryName/$name");

  Future<void> _deleteDirectory(Directory directory) async {
    if (await directory.exists()) await directory.delete(recursive: true);
  }

  Future<UuidValue?> _readLocalOwnerId() async {
    final ownerFile = File("${await _directoryPath()}/$_localOwnerFileName");
    if (!await ownerFile.exists()) return null;
    return UuidValue.withValidation((await ownerFile.readAsString()).trim());
  }

  Future<UuidValue> _createLocalOwnerId() async {
    final ownerId = const Uuid().v7obj();
    await File("${await _directoryPath()}/$_localOwnerFileName").writeAsString(ownerId.uuid);
    return ownerId;
  }

  Future<String> _directoryPath() async => (await getApplicationSupportDirectory()).path;

  Future<String> _localDatabasePath() async => "${await _directoryPath()}/$_localDatabaseName";

  Future<String> _userDatabasePath(UuidValue userId) async =>
      "${await _directoryPath()}/$_userDatabasePrefix${userId.uuid}$_databaseExtension";
}
