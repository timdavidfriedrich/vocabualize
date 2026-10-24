import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/models/remote_sync_state.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class SyncDataSource {
  Stream<RemoteSyncState> watchState();

  void start(OfflineSyncDatabaseSession session);

  Future<void> stop();

  Future<void> syncOnce(OfflineSyncDatabaseSession session);
}

@LazySingleton(as: SyncDataSource)
class SyncDataSourceImpl(
  final Client _client,
  final ConnectivityMonitor _connectivityMonitor,
) implements SyncDataSource {
  final _stateChanges = StreamController<RemoteSyncState>.broadcast();
  RemoteSyncState _state = RemoteSyncState.inactive;
  OfflineSyncDatabaseSession? _session;
  OfflineSyncSubscription? _subscription;
  AppLifecycleListener? _lifecycleListener;

  @override
  Stream<RemoteSyncState> watchState() async* {
    yield _state;
    yield* _stateChanges.stream;
  }

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
    _setState(RemoteSyncState.inactive);
  }

  @override
  Future<void> syncOnce(OfflineSyncDatabaseSession session) =>
      _client.offlineSync.syncOnce(session);

  void _onConnectivityChanged(bool connected) {
    if (connected) {
      _reconnectIfIdle();
    } else if (_session != null) {
      _setState(RemoteSyncState.unreachable);
    }
  }

  void _reconnectIfIdle() {
    final session = _session;
    if (session != null && _subscription == null) _connect(session);
  }

  void _connect(OfflineSyncDatabaseSession session) {
    _setState(RemoteSyncState.connecting);
    final subscription = _client.offlineSync.syncContinuously(
      session,
      onMergeSuccess: (_, _) {
        if (identical(_session, session)) _setState(RemoteSyncState.live);
      },
    );
    _subscription = subscription;
    void finish(RemoteSyncState state) {
      if (!identical(_subscription, subscription)) return;
      _subscription = null;
      _setState(state);
    }

    unawaited(
      subscription.done.then(
        (_) => finish(RemoteSyncState.unreachable),
        onError: (Object error) => finish(switch (error) {
          OfflineSyncTablesHashMismatchException() => RemoteSyncState.updateRequired,
          ServerpodClientUnauthorized() => RemoteSyncState.unauthorized,
          _ => RemoteSyncState.unreachable,
        }),
      ),
    );
  }

  Future<void> _cancelSubscription() async {
    final subscription = _subscription;
    _subscription = null;
    await subscription?.cancel();
  }

  void _setState(RemoteSyncState state) {
    if (state == _state) return;
    _state = state;
    _stateChanges.add(state);
  }
}
