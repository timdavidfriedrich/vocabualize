import 'dart:async';

import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:shared/data/models/storage_space.dart';

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
