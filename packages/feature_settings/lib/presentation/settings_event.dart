sealed class SettingsEvent {
  const SettingsEvent();
}

class const SettingsStarted() extends SettingsEvent;

class const SettingsGoogleSignInRequested() extends SettingsEvent;

class const SettingsSignOutRequested({
  required final bool discardUnsyncedChanges,
}) extends SettingsEvent;

class const SettingsSignOutDismissed() extends SettingsEvent;
