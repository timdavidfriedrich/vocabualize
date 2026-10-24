import 'package:shared/data/models/remote_sync_state.dart';
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
