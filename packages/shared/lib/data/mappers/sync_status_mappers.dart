import 'package:shared/data/models/remote_data_readiness.dart';
import 'package:shared/data/models/remote_sync_state.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/sync_status.dart';

extension RemoteSyncStateMappers on RemoteSyncState {
  SyncStatus toSyncStatus() => switch (this) {
    RemoteSyncState.inactive => SyncStatus.disabled,
    RemoteSyncState.connecting => SyncStatus.connecting,
    RemoteSyncState.live => SyncStatus.synced,
    RemoteSyncState.offline => SyncStatus.offline,
    RemoteSyncState.serverUnreachable => SyncStatus.serverUnreachable,
    RemoteSyncState.unauthorized => SyncStatus.signInRequired,
    RemoteSyncState.updateRequired => SyncStatus.updateRequired,
    RemoteSyncState.clockDrift => SyncStatus.clockWrong,
    RemoteSyncState.failed => SyncStatus.failed,
  };
}

extension RemoteDataReadinessMappers on RemoteDataReadiness {
  DataReadiness toDataReadiness() => switch (this) {
    RemoteDataReadiness.ready => const DataReady(),
    RemoteDataReadiness.downloading => const DataDownloading(),
    RemoteDataReadiness.offline => const DataUnavailable(reason: DataUnavailableReason.offline),
    RemoteDataReadiness.serverUnreachable => const DataUnavailable(
      reason: DataUnavailableReason.serverUnreachable,
    ),
    RemoteDataReadiness.unauthorized => const DataUnavailable(
      reason: DataUnavailableReason.signInRequired,
    ),
    RemoteDataReadiness.updateRequired => const DataUnavailable(
      reason: DataUnavailableReason.updateRequired,
    ),
    RemoteDataReadiness.clockDrift => const DataUnavailable(
      reason: DataUnavailableReason.clockWrong,
    ),
    RemoteDataReadiness.failed => const DataUnavailable(reason: DataUnavailableReason.syncFailed),
  };
}
