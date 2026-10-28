import 'package:flutter/material.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension SyncStatusExtensions on SyncStatus {
  String? toLabel(BuildContext context) => switch (this) {
    SyncStatus.disabled => null,
    SyncStatus.connecting => context.s.syncStatusConnecting,
    SyncStatus.syncing => context.s.syncStatusSyncing,
    SyncStatus.synced => context.s.syncStatusSynced,
    SyncStatus.offline => context.s.syncStatusOffline,
    SyncStatus.serverUnreachable => context.s.syncStatusServerUnreachable,
    SyncStatus.updateRequired => context.s.syncStatusUpdateRequired,
    SyncStatus.signInRequired => context.s.syncStatusSignInRequired,
    SyncStatus.clockWrong => context.s.syncStatusClockWrong,
    SyncStatus.failed => context.s.syncStatusFailed,
  };

  IconData? get badgeIcon => switch (this) {
    SyncStatus.disabled || SyncStatus.connecting || SyncStatus.syncing || SyncStatus.synced => null,
    SyncStatus.offline || SyncStatus.serverUnreachable => Icons.cloud_off_rounded,
    SyncStatus.updateRequired ||
    SyncStatus.signInRequired ||
    SyncStatus.clockWrong ||
    SyncStatus.failed => Icons.priority_high_rounded,
  };

  bool get needsAttention => switch (this) {
    SyncStatus.offline ||
    SyncStatus.serverUnreachable ||
    SyncStatus.updateRequired ||
    SyncStatus.signInRequired ||
    SyncStatus.clockWrong ||
    SyncStatus.failed => true,
    SyncStatus.disabled ||
    SyncStatus.connecting ||
    SyncStatus.syncing ||
    SyncStatus.synced => false,
  };

  bool get needsAction => switch (this) {
    SyncStatus.updateRequired ||
    SyncStatus.signInRequired ||
    SyncStatus.clockWrong ||
    SyncStatus.failed => true,
    SyncStatus.disabled ||
    SyncStatus.connecting ||
    SyncStatus.syncing ||
    SyncStatus.synced ||
    SyncStatus.offline ||
    SyncStatus.serverUnreachable => false,
  };
}
