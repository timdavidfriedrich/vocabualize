import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _initialRetryDelay = Duration(seconds: 2);
const _maximumRetryDelay = Duration(minutes: 1);

abstract class SyncDataSource {
  void start(OfflineSyncDatabaseSession session);

  Future<void> stop();

  Future<void> syncOnce(OfflineSyncDatabaseSession session);
}

@LazySingleton(as: SyncDataSource)
class SyncDataSourceImpl(
  final Client _client,
) implements SyncDataSource {
  OfflineSyncDatabaseSession? _session;
  OfflineSyncSubscription? _subscription;
  Timer? _retryTimer;
  Duration _retryDelay = _initialRetryDelay;

  @override
  void start(OfflineSyncDatabaseSession session) {
    if (identical(_session, session) && _subscription != null) return;
    unawaited(stop());
    _session = session;
    _connect(session);
  }

  @override
  Future<void> stop() async {
    _session = null;
    _retryTimer?.cancel();
    _retryTimer = null;
    final subscription = _subscription;
    _subscription = null;
    await subscription?.cancel();
  }

  @override
  Future<void> syncOnce(OfflineSyncDatabaseSession session) =>
      _client.offlineSync.syncOnce(session);

  void _connect(OfflineSyncDatabaseSession session) {
    final subscription = _client.offlineSync.syncContinuously(
      session,
      onMergeSuccess: (_, _) => _retryDelay = _initialRetryDelay,
    );
    _subscription = subscription;
    unawaited(
      subscription.done.then(
        (_) => _scheduleRetry(session),
        onError: (Object _) => _scheduleRetry(session),
      ),
    );
  }

  void _scheduleRetry(OfflineSyncDatabaseSession session) {
    if (!identical(_session, session)) return;
    _subscription = null;
    _retryTimer?.cancel();
    _retryTimer = Timer(_retryDelay, () {
      if (identical(_session, session)) _connect(session);
    });
    final doubled = _retryDelay * 2;
    _retryDelay = doubled > _maximumRetryDelay ? _maximumRetryDelay : doubled;
  }
}
