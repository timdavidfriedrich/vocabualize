sealed class SettingsEvent {
  const SettingsEvent();
}

class const SettingsStarted() extends SettingsEvent;

class const SettingsGoogleSignInRequested() extends SettingsEvent;

class const SettingsSignOutRequested({
  required final bool discardUnsyncedChanges,
}) extends SettingsEvent;

class const SettingsSignOutDismissed() extends SettingsEvent;

class const SettingsAccountConflictResolved({
  required final bool keepsPreviousAccount,
}) extends SettingsEvent;

class const SettingsBackupExportRequested() extends SettingsEvent;

class const SettingsBackupImportRequested() extends SettingsEvent;
