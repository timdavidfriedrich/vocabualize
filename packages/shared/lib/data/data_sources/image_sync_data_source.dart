import 'dart:async';

import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';

abstract class ImageSyncDataSource {
  void start(OfflineSyncDatabaseSession session);

  Future<void> stop();

  Future<bool> uploadPending(OfflineSyncDatabaseSession session);

  Stream<bool> watchTransferring();
}
