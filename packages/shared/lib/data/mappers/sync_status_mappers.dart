import 'package:shared/data/models/remote_data_readiness.dart';
import 'package:shared/data/models/remote_sync_state.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/sync_status.dart';

extension RemoteSyncStateMappers on RemoteSyncState {
  SyncStatus toSyncStatus() => switch (this) {
    RemoteSyncState.inactive => SyncStatus.disabled,
    RemoteSyncState.connecting => SyncStatus.connecting,
    RemoteSyncState.live => SyncStatus.synced,
    RemoteSyncState.unreachable => SyncStatus.offline,
    RemoteSyncState.updateRequired => SyncStatus.updateRequired,
    RemoteSyncState.unauthorized => SyncStatus.signInRequired,
  };
}

extension RemoteDataReadinessMappers on RemoteDataReadiness {
  DataReadiness toDataReadiness() => switch (this) {
    RemoteDataReadiness.ready => const DataReady(),
    RemoteDataReadiness.downloading => const DataDownloading(),
    RemoteDataReadiness.offline => const DataUnavailable(reason: DataUnavailableReason.offline),
    RemoteDataReadiness.unauthorized => const DataUnavailable(
      reason: DataUnavailableReason.signInRequired,
    ),
    RemoteDataReadiness.updateRequired => const DataUnavailable(
      reason: DataUnavailableReason.updateRequired,
    ),
  };
}
