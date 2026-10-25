import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/models/remote_clock_state.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _maxClockDrift = Duration(minutes: 1);

class const ClockWrongException() implements Exception;

abstract class ClockDataSource {
  Stream<RemoteClockState> watchState();

  Future<RemoteClockState> checkWithServer();

  bool isWriteBlocked();
}

@LazySingleton(as: ClockDataSource)
class ClockDataSourceImpl(
  final Client _client,
  final ConnectivityMonitor _connectivityMonitor,
) implements ClockDataSource {
  final _stateChanges = StreamController<RemoteClockState>.broadcast();
  final _monotonicClock = Stopwatch()..start();
  RemoteClockState _state = RemoteClockState.unknown;
  ({DateTime serverTime, Duration monotonicTime})? _reference;
  AppLifecycleListener? _lifecycleListener;
  int _generation = 0;

  @PostConstruct()
  void listenToEvents() {
    _lifecycleListener ??= AppLifecycleListener(
      onHide: _forgetReference,
      onPause: _forgetReference,
      onResume: () => unawaited(checkWithServer()),
    );
    _connectivityMonitor.addListener((isConnected) {
      if (isConnected) unawaited(checkWithServer());
    });
    unawaited(checkWithServer());
  }

  @override
  Stream<RemoteClockState> watchState() async* {
    yield _state;
    yield* _stateChanges.stream;
  }

  @override
  Future<RemoteClockState> checkWithServer() async {
    final generation = _generation;
    final requestedAt = _monotonicClock.elapsed;
    try {
      final serverTime = (await _client.config.serverTime()).toUtc();
      if (generation != _generation) return _state;
      final receivedAt = _monotonicClock.elapsed;
      final serverNow = serverTime.add((receivedAt - requestedAt) ~/ 2);
      _reference = (serverTime: serverNow, monotonicTime: receivedAt);
      _setState(
        _isDrifted(serverNow) ? RemoteClockState.wrong : RemoteClockState.correct,
      );
    } on Object {
      if (generation == _generation) {
        _reference = null;
        _setState(RemoteClockState.unknown);
      }
    }
    return _state;
  }

  @override
  bool isWriteBlocked() {
    final reference = _reference;
    if (reference == null) return false;
    final estimatedServerNow = reference.serverTime.add(
      _monotonicClock.elapsed - reference.monotonicTime,
    );
    final isDrifted = _isDrifted(estimatedServerNow);
    final isConfirmed = _state == RemoteClockState.wrong;
    if (isDrifted != isConfirmed) unawaited(checkWithServer());
    return isDrifted && isConfirmed;
  }

  void _forgetReference() {
    _generation++;
    _reference = null;
    _setState(RemoteClockState.unknown);
  }

  bool _isDrifted(DateTime serverNow) =>
      DateTime.now().toUtc().difference(serverNow).abs() > _maxClockDrift;

  void _setState(RemoteClockState state) {
    if (state == _state) return;
    _state = state;
    _stateChanges.add(state);
  }
}
