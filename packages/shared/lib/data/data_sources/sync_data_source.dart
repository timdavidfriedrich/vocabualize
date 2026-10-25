import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';
import 'package:shared/data/data_sources/space_storage_data_source.dart';
import 'package:shared/data/models/remote_clock_state.dart';
import 'package:shared/data/models/remote_data_readiness.dart';
import 'package:shared/data/models/remote_sync_state.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _firstGatewayErrorCode = 502;

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
  final SpaceStorageDataSource _storage,
  final ClockDataSource _clock,
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
  bool _mayReconnectImmediately = true;
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
    _mayReconnectImmediately = true;
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
    if (!_isRetryable(_readiness)) return;
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
      await _storage.markInitialSyncCompleted(userId);
      if (generation != _generation) return;
      _setReadiness(RemoteDataReadiness.ready);
      _connect(session);
    } on Object catch (error) {
      final state = await _failureState(error, canRetryImmediately: false);
      if (generation != _generation) return;
      _setState(state);
      _setReadiness(switch (state) {
        RemoteSyncState.offline => RemoteDataReadiness.offline,
        RemoteSyncState.serverUnreachable => RemoteDataReadiness.serverUnreachable,
        RemoteSyncState.unauthorized => RemoteDataReadiness.unauthorized,
        RemoteSyncState.updateRequired => RemoteDataReadiness.updateRequired,
        RemoteSyncState.clockDrift => RemoteDataReadiness.clockDrift,
        RemoteSyncState.failed ||
        RemoteSyncState.inactive ||
        RemoteSyncState.connecting ||
        RemoteSyncState.live => RemoteDataReadiness.failed,
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
      _setState(RemoteSyncState.offline);
    }
  }

  void _resume() {
    final session = _session;
    if (session == null) return;
    _mayReconnectImmediately = true;
    switch (_readiness) {
      case RemoteDataReadiness.ready when _subscription == null:
        _connect(session);
      case final readiness when _isRetryable(readiness):
        retryInitialSync();
      case _:
        break;
    }
  }

  void _connect(OfflineSyncDatabaseSession session) {
    _setState(RemoteSyncState.connecting);
    var hasBeenLive = false;
    var hasUnconfirmedChanges = false;
    final syncClient = OfflineSyncClient(
      ({required changes, required once}) => _client.modules.offline_sync.offlineSync
          .sync(
            changes: changes.map((event) {
              if (event is OfflineSyncMergeChunk) hasUnconfirmedChanges = true;
              return event;
            }),
            once: once,
          )
          .map((event) {
            if (!identical(_session, session)) return event;
            switch (event) {
              case OfflineSyncMergeChunk():
                _mayReconnectImmediately = true;
              case OfflineSyncEndOfBatch():
                hasBeenLive = true;
                if (hasUnconfirmedChanges) {
                  hasUnconfirmedChanges = false;
                  _mayReconnectImmediately = true;
                }
                _setState(RemoteSyncState.live);
              default:
                break;
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
      final isConnectionLoss =
          state == RemoteSyncState.offline || state == RemoteSyncState.serverUnreachable;
      if (hasBeenLive &&
          isConnectionLoss &&
          _mayReconnectImmediately &&
          identical(_session, session)) {
        _mayReconnectImmediately = false;
        _connect(session);
      }
    }

    unawaited(
      subscription.done.then(
        (_) async => finish(
          await _untypedFailureState(
            isConnectionError: true,
            canRetryImmediately: hasBeenLive && _mayReconnectImmediately,
          ),
        ),
        onError: (Object error) async => finish(
          await _failureState(
            error,
            canRetryImmediately: hasBeenLive && _mayReconnectImmediately,
          ),
        ),
      ),
    );
  }

  bool _isRetryable(RemoteDataReadiness readiness) => switch (readiness) {
    RemoteDataReadiness.offline ||
    RemoteDataReadiness.serverUnreachable ||
    RemoteDataReadiness.clockDrift ||
    RemoteDataReadiness.failed => true,
    RemoteDataReadiness.ready ||
    RemoteDataReadiness.downloading ||
    RemoteDataReadiness.unauthorized ||
    RemoteDataReadiness.updateRequired => false,
  };

  Future<RemoteSyncState> _failureState(
    Object error, {
    required bool canRetryImmediately,
  }) async => switch (error) {
    OfflineSyncTablesHashMismatchException() => RemoteSyncState.updateRequired,
    ServerpodClientUnauthorized() => RemoteSyncState.unauthorized,
    OpenMethodStreamException(responseType: OpenMethodStreamResponseType.authenticationFailed) =>
      RemoteSyncState.unauthorized,
    ClockDriftException() => RemoteSyncState.clockDrift,
    OpenMethodStreamException() => RemoteSyncState.failed,
    MethodStreamException() ||
    ServerpodClientNetworkException() ||
    OfflineSyncStreamClosedException() ||
    SocketException() ||
    HttpException() ||
    TimeoutException() => await _untypedFailureState(
      isConnectionError: true,
      canRetryImmediately: canRetryImmediately,
    ),
    ServerpodClientHttpException(:final statusCode) when statusCode >= _firstGatewayErrorCode =>
      await _untypedFailureState(isConnectionError: true, canRetryImmediately: canRetryImmediately),
    _ => await _untypedFailureState(isConnectionError: false, canRetryImmediately: false),
  };

  Future<RemoteSyncState> _untypedFailureState({
    required bool isConnectionError,
    required bool canRetryImmediately,
  }) async => switch (await _clock.checkWithServer()) {
    RemoteClockState.wrong => RemoteSyncState.clockDrift,
    RemoteClockState.correct when isConnectionError && canRetryImmediately =>
      RemoteSyncState.serverUnreachable,
    RemoteClockState.correct => RemoteSyncState.failed,
    RemoteClockState.unknown when isConnectionError => await _connectionLossState(),
    RemoteClockState.unknown => RemoteSyncState.failed,
  };

  Future<RemoteSyncState> _connectionLossState() async {
    final connections = await Connectivity().checkConnectivity();
    final hasNetwork = connections.any((connection) => connection != ConnectivityResult.none);
    return hasNetwork ? RemoteSyncState.serverUnreachable : RemoteSyncState.offline;
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

  void _setReadiness(RemoteDataReadiness readiness) {
    if (readiness == _readiness) return;
    _readiness = readiness;
    _readinessChanges.add(readiness);
  }
}
