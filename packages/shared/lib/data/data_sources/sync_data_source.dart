import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/models/remote_data_readiness.dart';
import 'package:shared/data/models/remote_sync_state.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class SyncDataSource {
  Stream<RemoteSyncState> watchState();

  Stream<RemoteDataReadiness> watchReadiness();

  void start(
    OfflineSyncDatabaseSession session, {
    required UuidValue userId,
    required bool needsInitialSync,
  });

  Future<void> stop();

  void retryInitialSync();

  Future<void> syncOnce(OfflineSyncDatabaseSession session);
}

@LazySingleton(as: SyncDataSource)
class SyncDataSourceImpl(
  final Client _client,
  final ConnectivityMonitor _connectivityMonitor,
  final DatabaseSessionDataSource _sessions,
) implements SyncDataSource {
  final _stateChanges = StreamController<RemoteSyncState>.broadcast();
  final _readinessChanges = StreamController<RemoteDataReadiness>.broadcast();
  RemoteSyncState _state = RemoteSyncState.inactive;
  RemoteDataReadiness _readiness = RemoteDataReadiness.ready;
  OfflineSyncDatabaseSession? _session;
  UuidValue? _userId;
  OfflineSyncSubscription? _subscription;
  AppLifecycleListener? _lifecycleListener;
  Future<void> _initialSyncs = Future<void>.value();
  bool _isInitialSyncRunning = false;
  int _generation = 0;

  @override
  Stream<RemoteSyncState> watchState() async* {
    yield _state;
    yield* _stateChanges.stream;
  }

  @override
  Stream<RemoteDataReadiness> watchReadiness() async* {
    yield _readiness;
    yield* _readinessChanges.stream;
  }

  @override
  void start(
    OfflineSyncDatabaseSession session, {
    required UuidValue userId,
    required bool needsInitialSync,
  }) {
    if (identical(_session, session) && (_subscription != null || _isInitialSyncRunning)) return;
    final generation = ++_generation;
    unawaited(_cancelSubscription());
    _session = session;
    _userId = userId;
    _connectivityMonitor.removeListener(_onConnectivityChanged);
    _connectivityMonitor.addListener(_onConnectivityChanged);
    _lifecycleListener ??= AppLifecycleListener(onResume: _resume);
    if (needsInitialSync) {
      _runInitialSync(session, userId, generation);
    } else {
      _setReadiness(RemoteDataReadiness.ready);
      _connect(session);
    }
  }

  @override
  Future<void> stop() async {
    _generation++;
    _session = null;
    _userId = null;
    _isInitialSyncRunning = false;
    _connectivityMonitor.removeListener(_onConnectivityChanged);
    _lifecycleListener?.dispose();
    _lifecycleListener = null;
    await _cancelSubscription();
    _setState(RemoteSyncState.inactive);
    _setReadiness(RemoteDataReadiness.ready);
  }

  @override
  void retryInitialSync() {
    final session = _session;
    final userId = _userId;
    if (session == null || userId == null || _isInitialSyncRunning) return;
    if (_readiness != RemoteDataReadiness.offline) return;
    _runInitialSync(session, userId, _generation);
  }

  @override
  Future<void> syncOnce(OfflineSyncDatabaseSession session) async {
    await _initialSyncs;
    await _client.offlineSync.syncOnce(session);
  }

  void _runInitialSync(OfflineSyncDatabaseSession session, UuidValue userId, int generation) {
    _isInitialSyncRunning = true;
    _setReadiness(RemoteDataReadiness.downloading);
    _setState(RemoteSyncState.connecting);
    _initialSyncs = _initialSyncs.then(
      (_) => _performInitialSync(session, userId, generation),
    );
  }

  Future<void> _performInitialSync(
    OfflineSyncDatabaseSession session,
    UuidValue userId,
    int generation,
  ) async {
    try {
      await _client.offlineSync.syncOnce(session);
      if (generation != _generation) return;
      await _sessions.markInitialSyncCompleted(userId);
      if (generation != _generation) return;
      _setReadiness(RemoteDataReadiness.ready);
      _connect(session);
    } on Object catch (error) {
      if (generation != _generation) return;
      final state = _failureState(error);
      _setState(state);
      _setReadiness(switch (state) {
        RemoteSyncState.updateRequired => RemoteDataReadiness.updateRequired,
        RemoteSyncState.unauthorized => RemoteDataReadiness.unauthorized,
        _ => RemoteDataReadiness.offline,
      });
    } finally {
      if (generation == _generation) _isInitialSyncRunning = false;
    }
  }

  void _onConnectivityChanged(bool connected) {
    if (connected) {
      _resume();
    } else if (_session != null && _readiness == RemoteDataReadiness.ready) {
      unawaited(_cancelSubscription());
      _setState(RemoteSyncState.unreachable);
    }
  }

  void _resume() {
    final session = _session;
    if (session == null) return;
    switch (_readiness) {
      case RemoteDataReadiness.offline:
        retryInitialSync();
      case RemoteDataReadiness.ready when _subscription == null:
        _connect(session);
      case RemoteDataReadiness.ready ||
          RemoteDataReadiness.downloading ||
          RemoteDataReadiness.unauthorized ||
          RemoteDataReadiness.updateRequired:
        break;
    }
  }

  void _connect(OfflineSyncDatabaseSession session) {
    _setState(RemoteSyncState.connecting);
    var hasBeenLive = false;
    final syncClient = OfflineSyncClient(
      ({required changes, required once}) => _client.modules.offline_sync.offlineSync
          .sync(changes: changes, once: once)
          .map((event) {
            if (event is OfflineSyncEndOfBatch && identical(_session, session)) {
              hasBeenLive = true;
              _setState(RemoteSyncState.live);
            }
            return event;
          }),
    );
    final subscription = syncClient.syncContinuously(session);
    _subscription = subscription;
    void finish(RemoteSyncState state) {
      if (!identical(_subscription, subscription)) return;
      _subscription = null;
      _setState(state);
      if (hasBeenLive && state == RemoteSyncState.unreachable && identical(_session, session)) {
        _connect(session);
      }
    }

    unawaited(
      subscription.done.then(
        (_) => finish(RemoteSyncState.unreachable),
        onError: (Object error) => finish(_failureState(error)),
      ),
    );
  }

  RemoteSyncState _failureState(Object error) => switch (error) {
    OfflineSyncTablesHashMismatchException() => RemoteSyncState.updateRequired,
    ServerpodClientUnauthorized() => RemoteSyncState.unauthorized,
    _ => RemoteSyncState.unreachable,
  };

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

  void _setReadiness(RemoteDataReadiness readiness) {
    if (readiness == _readiness) return;
    _readiness = readiness;
    _readinessChanges.add(readiness);
  }
}
