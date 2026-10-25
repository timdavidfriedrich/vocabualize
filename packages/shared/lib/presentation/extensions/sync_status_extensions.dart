import 'package:flutter/material.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension SyncStatusExtensions on SyncStatus {
  String? toLabel(BuildContext context) => switch (this) {
    SyncStatus.disabled => null,
    SyncStatus.connecting => context.s.syncStatusConnecting,
    SyncStatus.synced => context.s.syncStatusSynced,
    SyncStatus.offline => context.s.syncStatusOffline,
    SyncStatus.serverUnreachable => context.s.syncStatusServerUnreachable,
    SyncStatus.updateRequired => context.s.syncStatusUpdateRequired,
    SyncStatus.signInRequired => context.s.syncStatusSignInRequired,
    SyncStatus.clockWrong => context.s.syncStatusClockWrong,
    SyncStatus.failed => context.s.syncStatusFailed,
  };

  IconData? get icon => switch (this) {
    SyncStatus.disabled => null,
    SyncStatus.connecting => Icons.cloud_sync_rounded,
    SyncStatus.synced => Icons.cloud_done_rounded,
    SyncStatus.offline || SyncStatus.serverUnreachable => Icons.cloud_off_rounded,
    SyncStatus.updateRequired => Icons.system_update_rounded,
    SyncStatus.signInRequired || SyncStatus.failed => Icons.sync_problem_rounded,
    SyncStatus.clockWrong => Icons.schedule_rounded,
  };

  bool get needsAction => switch (this) {
    SyncStatus.updateRequired ||
    SyncStatus.signInRequired ||
    SyncStatus.clockWrong ||
    SyncStatus.failed => true,
    SyncStatus.disabled ||
    SyncStatus.connecting ||
    SyncStatus.synced ||
    SyncStatus.offline ||
    SyncStatus.serverUnreachable => false,
  };
}
