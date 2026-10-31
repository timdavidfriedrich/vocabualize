import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';
import 'package:shared/data/data_sources/space_storage_data_source.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:shared/data/models/storage_space.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class DatabaseSessionDataSource {
  OfflineSyncDatabaseSession? get currentSession;

  StorageSpace? get currentSpace;

  OfflineSyncDatabaseSession requireWritableSession();

  Stream<OfflineSyncDatabaseSession?> watchSession();

  Future<OfflineSyncDatabaseSession> open(StorageSpace space);

  Future<void> close();

  Future<LocalSnapshot> readCurrentSnapshot();

  Future<LocalSnapshot?> readSnapshot(StorageSpace space);
}

@LazySingleton(as: DatabaseSessionDataSource)
class DatabaseSessionDataSourceImpl(
  final Client _client,
  final ClockDataSource _clock,
  final SpaceStorageDataSource _storage,
) implements DatabaseSessionDataSource {
  final _sessionChanges = StreamController<OfflineSyncDatabaseSession?>.broadcast();
  OfflineSyncDatabaseSession? _session;
  StorageSpace? _space;

  @override
  OfflineSyncDatabaseSession? get currentSession => _session;

  @override
  StorageSpace? get currentSpace => _space;

  @override
  OfflineSyncDatabaseSession requireWritableSession() {
    final session = _session;
    if (session == null) throw StateError("No database is open.");
    if (_clock.isWriteBlocked()) throw const ClockWrongException();
    return session;
  }

  @override
  Stream<OfflineSyncDatabaseSession?> watchSession() async* {
    yield _session;
    yield* _sessionChanges.stream;
  }

  @override
  Future<OfflineSyncDatabaseSession> open(StorageSpace space) async {
    if ((_session, _space) case (final session?, final current?) when current == space) {
      return session;
    }
    await close();
    await _storage.createSpace(space);
    final session = await _client.createSyncSession(
      await _storage.databasePath(space),
      isDebugMode: kDebugMode,
      persistentUserId: await _ownerId(space),
    );
    _session = session;
    _space = space;
    _sessionChanges.add(session);
    return session;
  }

  @override
  Future<void> close() async {
    final session = _session;
    _session = null;
    _space = null;
    _sessionChanges.add(null);
    await session?.close();
  }

  @override
  Future<LocalSnapshot> readCurrentSnapshot() async {
    final session = _session;
    if (session == null) throw StateError("No database is open.");
    return _readSnapshot(session);
  }

  @override
  Future<LocalSnapshot?> readSnapshot(StorageSpace space) async {
    if ((_session, _space) case (final session?, final current?) when current == space) {
      return _readSnapshot(session);
    }
    if (!await _storage.hasDatabase(space)) return null;
    final ownerId = switch (space) {
      LocalOnlySpace() => await _storage.readLocalOwnerId(),
      AccountSpace(:final userId) => userId,
    };
    if (ownerId == null) return null;
    final session = await _client.createSyncSession(
      await _storage.databasePath(space),
      isDebugMode: kDebugMode,
      persistentUserId: ownerId,
    );
    try {
      return await _readSnapshot(session);
    } finally {
      await session.close();
    }
  }

  Future<UuidValue> _ownerId(StorageSpace space) => switch (space) {
    LocalOnlySpace() => _storage.readOrCreateLocalOwnerId(),
    AccountSpace(:final userId) => Future.value(userId),
  };

  Future<LocalSnapshot> _readSnapshot(OfflineSyncDatabaseSession session) async {
    return LocalSnapshot(
      vocabularies: await LocalVocabulary.db.find(session),
      translations: await LocalTranslation.db.find(session),
      progress: await LocalProgress.db.find(session),
      tags: await LocalTag.db.find(session),
      vocabularyTags: await LocalVocabularyTag.db.find(session),
      activities: await LocalActivity.db.find(session),
      settings: await LocalSetting.db.find(session),
    );
  }
}
