sealed class SettingsEvent {
  const SettingsEvent();
}

class const SettingsStarted() extends SettingsEvent;

class const SettingsGoogleSignInRequested() extends SettingsEvent;
