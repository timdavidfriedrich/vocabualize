import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

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

class const SettingsAppearanceModeChanged({
  required final AppearanceMode mode,
}) extends SettingsEvent;

class const SettingsReminderToggled({
  required final ReminderKind kind,
  required final bool isEnabled,
}) extends SettingsEvent;

class const SettingsReminderTimeChanged({
  required final ReminderKind kind,
  required final int hour,
  required final int minute,
}) extends SettingsEvent;

class const SettingsNotificationSettingsOpened() extends SettingsEvent;

class const SettingsStoreListingOpened() extends SettingsEvent;

class const SettingsPrivacyPolicyOpened({
  required final String languageCode,
}) extends SettingsEvent;

class const SettingsDeletionRequested() extends SettingsEvent;

class const SettingsBackupExportRequested() extends SettingsEvent;

class const SettingsBackupImportRequested() extends SettingsEvent;
