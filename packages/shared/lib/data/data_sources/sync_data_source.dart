import 'dart:async';

import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/models/remote_data_readiness.dart';
import 'package:shared/data/models/remote_sync_state.dart';

abstract class SyncDataSource {
  Stream<RemoteSyncState> watchState();

  Stream<RemoteDataReadiness> watchReadiness();

  Stream<bool> watchTransferring();

  void start(
    OfflineSyncDatabaseSession session, {
    required UuidValue userId,
    required bool needsInitialSync,
  });

  Future<void> stop();

  void retryInitialSync();

  Future<void> syncOnce(OfflineSyncDatabaseSession session);
}
