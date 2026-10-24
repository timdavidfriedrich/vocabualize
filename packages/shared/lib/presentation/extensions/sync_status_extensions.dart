import 'package:flutter/material.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension SyncStatusExtensions on SyncStatus {
  String? toLabel(BuildContext context) => switch (this) {
    SyncStatus.disabled => null,
    SyncStatus.connecting => context.s.syncStatusConnecting,
    SyncStatus.synced => context.s.syncStatusSynced,
    SyncStatus.offline => context.s.syncStatusOffline,
    SyncStatus.updateRequired => context.s.syncStatusUpdateRequired,
    SyncStatus.signInRequired => context.s.syncStatusSignInRequired,
  };

  IconData? get icon => switch (this) {
    SyncStatus.disabled => null,
    SyncStatus.connecting => Icons.cloud_sync_rounded,
    SyncStatus.synced => Icons.cloud_done_rounded,
    SyncStatus.offline => Icons.cloud_off_rounded,
    SyncStatus.updateRequired => Icons.system_update_rounded,
    SyncStatus.signInRequired => Icons.sync_problem_rounded,
  };

  bool get needsAction => switch (this) {
    SyncStatus.updateRequired || SyncStatus.signInRequired => true,
    SyncStatus.disabled ||
    SyncStatus.connecting ||
    SyncStatus.synced ||
    SyncStatus.offline => false,
  };
}
