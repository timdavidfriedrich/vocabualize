import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class SyncDataSource {
  void start(OfflineSyncDatabaseSession session);

  Future<void> stop();

  Future<void> syncOnce(OfflineSyncDatabaseSession session);
}

@LazySingleton(as: SyncDataSource)
class SyncDataSourceImpl(
  final Client _client,
  final ConnectivityMonitor _connectivityMonitor,
) implements SyncDataSource {
  OfflineSyncDatabaseSession? _session;
  OfflineSyncSubscription? _subscription;
  AppLifecycleListener? _lifecycleListener;

  @override
  void start(OfflineSyncDatabaseSession session) {
    if (identical(_session, session) && _subscription != null) return;
    unawaited(_cancelSubscription());
    _session = session;
    _connectivityMonitor.addListener(_onConnectivityChanged);
    _lifecycleListener ??= AppLifecycleListener(onResume: _reconnectIfIdle);
    _connect(session);
  }

  @override
  Future<void> stop() async {
    _session = null;
    _connectivityMonitor.removeListener(_onConnectivityChanged);
    _lifecycleListener?.dispose();
    _lifecycleListener = null;
    await _cancelSubscription();
  }

  @override
  Future<void> syncOnce(OfflineSyncDatabaseSession session) =>
      _client.offlineSync.syncOnce(session);

  void _onConnectivityChanged(bool connected) {
    if (connected) _reconnectIfIdle();
  }

  void _reconnectIfIdle() {
    final session = _session;
    if (session != null && _subscription == null) _connect(session);
  }

  void _connect(OfflineSyncDatabaseSession session) {
    final subscription = _client.offlineSync.syncContinuously(session);
    _subscription = subscription;
    void release(_) {
      if (identical(_subscription, subscription)) _subscription = null;
    }

    unawaited(subscription.done.then(release, onError: release));
  }

  Future<void> _cancelSubscription() async {
    final subscription = _subscription;
    _subscription = null;
    await subscription?.cancel();
  }
}
