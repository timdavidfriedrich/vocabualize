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

class const SettingsTypeAnswerDisabledChanged({
  required final bool isDisabled,
}) extends SettingsEvent;

class const SettingsImagesHiddenChanged({
  required final bool areHidden,
}) extends SettingsEvent;

class const SettingsPracticeReminderToggled({
  required final bool isEnabled,
}) extends SettingsEvent;

class const SettingsPracticeReminderTimeChanged({
  required final int hour,
  required final int minute,
}) extends SettingsEvent;

class const SettingsNotificationSettingsOpened() extends SettingsEvent;

class const SettingsDeletionRequested() extends SettingsEvent;

class const SettingsBackupExportRequested() extends SettingsEvent;

class const SettingsBackupImportRequested() extends SettingsEvent;
