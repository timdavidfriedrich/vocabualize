import 'package:core/config/build_config.dart';
import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';
import 'package:shared/domain/repositories/backup_repository.dart';
import 'package:shared/domain/repositories/external_link_repository.dart';
import 'package:shared/domain/repositories/reminder_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

const _germanLanguageCode = "de";
const _privacyPolicyPath = "/privacy/";
const _germanPrivacyPolicyPath = "/de/datenschutz/";

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._accountRepository,
    this._backupRepository,
    this._settingsRepository,
    this._reminderRepository,
    this._appInfoRepository,
    this._externalLinkRepository,
  ) : super(const SettingsLoading()) {
    on<SettingsStarted>(_onStarted);
    on<SettingsGoogleSignInRequested>(_onGoogleSignInRequested);
    on<SettingsSignOutRequested>(_onSignOutRequested);
    on<SettingsSignOutDismissed>(_onSignOutDismissed);
    on<SettingsAccountConflictResolved>(_onAccountConflictResolved);
    on<SettingsTypeAnswerDisabledChanged>(_onTypeAnswerDisabledChanged);
    on<SettingsImagesHiddenChanged>(_onImagesHiddenChanged);
    on<SettingsAppearanceModeChanged>(_onAppearanceModeChanged);
    on<SettingsReminderToggled>(_onReminderToggled);
    on<SettingsReminderTimeChanged>(_onReminderTimeChanged);
    on<SettingsNotificationSettingsOpened>(_onNotificationSettingsOpened);
    on<SettingsStoreListingOpened>(_onStoreListingOpened);
    on<SettingsPrivacyPolicyOpened>(_onPrivacyPolicyOpened);
    on<SettingsDeletionRequested>(_onDeletionRequested);
    on<SettingsBackupExportRequested>(_onBackupExportRequested);
    on<SettingsBackupImportRequested>(_onBackupImportRequested);
  }

  final AccountRepository _accountRepository;
  final BackupRepository _backupRepository;
  final SettingsRepository _settingsRepository;
  final ReminderRepository _reminderRepository;
  final AppInfoRepository _appInfoRepository;
  final ExternalLinkRepository _externalLinkRepository;

  Future<void> _onStarted(SettingsStarted event, Emitter<SettingsState> emit) {
    return emit.forEach(
      _accountRepository.watchAuthStatus(),
      onData: (result) => switch ((result, state)) {
        (Success(data: AuthAuthenticated(:final account)), final SettingsLoaded loaded) =>
          loaded.copyWith(account: account),
        (Success(data: AuthAuthenticated(:final account)), _) => SettingsLoaded(
          account: account,
          runningAction: null,
          isSignOutBlocked: false,
          importedCount: null,
          importProgress: null,
          accountConflict: null,
          error: null,
        ),
        _ => state,
      },
    );
  }

  Future<void> _onGoogleSignInRequested(
    SettingsGoogleSignInRequested event,
    Emitter<SettingsState> emit,
  ) async {
    if (state case final SettingsLoaded loaded) {
      emit(
        loaded.copyWith(
          runningAction: SettingsAction.signIn,
          accountConflict: null,
          error: null,
        ),
      );
    }
    final result = await _accountRepository.signInWithGoogle();
    if (state case final SettingsLoaded loaded) {
      emit(switch (result) {
        Success(data: SignedIn() || SignInCancelled()) => loaded.copyWith(runningAction: null),
        Success(data: final AccountConflict conflict) => loaded.copyWith(
          runningAction: null,
          accountConflict: conflict,
        ),
        Failure(:final error) => loaded.copyWith(runningAction: null, error: error),
      });
    }
  }

  Future<void> _onAccountConflictResolved(
    SettingsAccountConflictResolved event,
    Emitter<SettingsState> emit,
  ) => _run(
    emit,
    SettingsAction.signIn,
    () => _accountRepository.resolveAccountConflict(
      keepsPreviousAccount: event.keepsPreviousAccount,
    ),
  );

  Future<void> _onSignOutRequested(
    SettingsSignOutRequested event,
    Emitter<SettingsState> emit,
  ) => _run(
    emit,
    SettingsAction.signOut,
    () => _accountRepository.signOut(discardUnsyncedChanges: event.discardUnsyncedChanges),
  );

  void _onSignOutDismissed(SettingsSignOutDismissed event, Emitter<SettingsState> emit) {
    if (state case final SettingsLoaded loaded) emit(loaded.copyWith(isSignOutBlocked: false));
  }

  Future<void> _onTypeAnswerDisabledChanged(
    SettingsTypeAnswerDisabledChanged event,
    Emitter<SettingsState> emit,
  ) => _savePreference(emit, () => _settingsRepository.setTypeAnswerDisabled(event.isDisabled));

  Future<void> _onImagesHiddenChanged(
    SettingsImagesHiddenChanged event,
    Emitter<SettingsState> emit,
  ) => _savePreference(emit, () => _settingsRepository.setImagesHidden(event.areHidden));

  Future<void> _onAppearanceModeChanged(
    SettingsAppearanceModeChanged event,
    Emitter<SettingsState> emit,
  ) => _savePreference(emit, () => _settingsRepository.setAppearanceMode(event.mode));

  Future<void> _onReminderToggled(
    SettingsReminderToggled event,
    Emitter<SettingsState> emit,
  ) async {
    if (event.isEnabled) await _reminderRepository.requestNotificationPermission();
    final reminder = await _currentReminder(event.kind);
    await _savePreference(
      emit,
      () => _settingsRepository.setReminder(
        event.kind,
        reminder.copyWith(isEnabled: event.isEnabled),
      ),
    );
  }

  Future<void> _onReminderTimeChanged(
    SettingsReminderTimeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final reminder = await _currentReminder(event.kind);
    await _savePreference(
      emit,
      () => _settingsRepository.setReminder(
        event.kind,
        reminder.copyWith(hour: event.hour, minute: event.minute),
      ),
    );
  }

  Future<void> _onNotificationSettingsOpened(
    SettingsNotificationSettingsOpened event,
    Emitter<SettingsState> emit,
  ) => _savePreference(emit, _appInfoRepository.openNotificationSettings);

  Future<void> _onStoreListingOpened(
    SettingsStoreListingOpened event,
    Emitter<SettingsState> emit,
  ) => _savePreference(emit, _appInfoRepository.openStoreListing);

  Future<void> _onPrivacyPolicyOpened(
    SettingsPrivacyPolicyOpened event,
    Emitter<SettingsState> emit,
  ) => _savePreference(
    emit,
    () => _externalLinkRepository.open(
      "$websiteUrl${event.languageCode == _germanLanguageCode ? _germanPrivacyPolicyPath : _privacyPolicyPath}",
    ),
  );

  Future<DailyReminder> _currentReminder(ReminderKind kind) async {
    return switch (await _settingsRepository.readPreferences()) {
      Success(:final data) => data.reminderOf(kind),
      Failure() => defaultPreferences.reminderOf(kind),
    };
  }

  Future<void> _savePreference(
    Emitter<SettingsState> emit,
    Future<AppResult<()>> Function() save,
  ) async {
    if (await save() case Failure(:final error)) {
      if (state case final SettingsLoaded loaded) emit(loaded.copyWith(error: error));
    }
  }

  Future<void> _onDeletionRequested(
    SettingsDeletionRequested event,
    Emitter<SettingsState> emit,
  ) => _run(emit, SettingsAction.deletion, _accountRepository.deleteAccount);

  Future<void> _onBackupExportRequested(
    SettingsBackupExportRequested event,
    Emitter<SettingsState> emit,
  ) => _run(emit, SettingsAction.backupExport, _backupRepository.exportBackup);

  Future<void> _onBackupImportRequested(
    SettingsBackupImportRequested event,
    Emitter<SettingsState> emit,
  ) async {
    if (state case final SettingsLoaded loaded) {
      emit(
        loaded.copyWith(
          runningAction: SettingsAction.backupImport,
          importedCount: null,
          importProgress: null,
          accountConflict: null,
          error: null,
        ),
      );
    }
    await emit.forEach(
      _backupRepository.importBackup(),
      onData: (result) => switch ((result, state)) {
        (Success(data: final BackupImportRunning running), final SettingsLoaded loaded) =>
          loaded.copyWith(importProgress: running),
        (
          Success(data: BackupImportCompleted(:final importedCount)),
          final SettingsLoaded loaded,
        ) =>
          loaded.copyWith(
            runningAction: null,
            importProgress: null,
            importedCount: importedCount,
          ),
        (Success(data: BackupImportCancelled()), final SettingsLoaded loaded) => loaded.copyWith(
          runningAction: null,
          importProgress: null,
        ),
        (Failure(:final error), final SettingsLoaded loaded) => loaded.copyWith(
          runningAction: null,
          importProgress: null,
          error: error,
        ),
        _ => state,
      },
    );
  }

  Future<void> _run<T>(
    Emitter<SettingsState> emit,
    SettingsAction runningAction,
    Future<AppResult<T>> Function() action,
  ) async {
    if (state case final SettingsLoaded loaded) {
      emit(
        loaded.copyWith(
          runningAction: runningAction,
          isSignOutBlocked: false,
          importedCount: null,
          accountConflict: null,
          error: null,
        ),
      );
    }
    final result = await action();
    if (state case final SettingsLoaded loaded) {
      emit(switch (result) {
        Success() => loaded.copyWith(runningAction: null, error: null),
        Failure(error: SyncPendingError()) => loaded.copyWith(
          runningAction: null,
          isSignOutBlocked: true,
        ),
        Failure(:final error) => loaded.copyWith(runningAction: null, error: error),
      });
    }
  }
}
