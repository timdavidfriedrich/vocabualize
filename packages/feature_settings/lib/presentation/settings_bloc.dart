import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';
import 'package:shared/domain/repositories/backup_repository.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._accountRepository, this._backupRepository, this._appInfoRepository)
    : super(const SettingsLoading()) {
    on<SettingsStarted>(_onStarted);
    on<SettingsGoogleSignInRequested>(_onGoogleSignInRequested);
    on<SettingsSignOutRequested>(_onSignOutRequested);
    on<SettingsSignOutDismissed>(_onSignOutDismissed);
    on<SettingsAccountConflictResolved>(_onAccountConflictResolved);
    on<SettingsDateSettingsRequested>(_onDateSettingsRequested);
    on<SettingsBackupExportRequested>(_onBackupExportRequested);
    on<SettingsBackupImportRequested>(_onBackupImportRequested);
  }

  final AccountRepository _accountRepository;
  final BackupRepository _backupRepository;
  final AppInfoRepository _appInfoRepository;

  Future<void> _onStarted(SettingsStarted event, Emitter<SettingsState> emit) {
    return emit.forEach(
      _accountRepository.watchAuthStatus(),
      onData: (result) => switch ((result, state)) {
        (Success(data: AuthAuthenticated(:final account)), final SettingsLoaded loaded) =>
          loaded.copyWith(account: account),
        (Success(data: AuthAuthenticated(:final account)), _) => SettingsLoaded(
          account: account,
          isBusy: false,
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
      emit(loaded.copyWith(isBusy: true, accountConflict: null, error: null));
    }
    final result = await _accountRepository.signInWithGoogle();
    if (state case final SettingsLoaded loaded) {
      emit(switch (result) {
        Success(data: SignedIn()) => loaded.copyWith(isBusy: false),
        Success(data: final AccountConflict conflict) => loaded.copyWith(
          isBusy: false,
          accountConflict: conflict,
        ),
        Failure(:final error) => loaded.copyWith(isBusy: false, error: error),
      });
    }
  }

  Future<void> _onDateSettingsRequested(
    SettingsDateSettingsRequested event,
    Emitter<SettingsState> emit,
  ) async {
    if (await _appInfoRepository.openDateSettings() case Failure(:final error)) {
      if (state case final SettingsLoaded loaded) emit(loaded.copyWith(error: error));
    }
  }

  Future<void> _onAccountConflictResolved(
    SettingsAccountConflictResolved event,
    Emitter<SettingsState> emit,
  ) => _runBusy(
    emit,
    () => _accountRepository.resolveAccountConflict(
      keepsPreviousAccount: event.keepsPreviousAccount,
    ),
  );

  Future<void> _onSignOutRequested(
    SettingsSignOutRequested event,
    Emitter<SettingsState> emit,
  ) => _runBusy(
    emit,
    () => _accountRepository.signOut(discardUnsyncedChanges: event.discardUnsyncedChanges),
  );

  void _onSignOutDismissed(SettingsSignOutDismissed event, Emitter<SettingsState> emit) {
    if (state case final SettingsLoaded loaded) emit(loaded.copyWith(isSignOutBlocked: false));
  }

  Future<void> _onBackupExportRequested(
    SettingsBackupExportRequested event,
    Emitter<SettingsState> emit,
  ) => _runBusy(emit, _backupRepository.exportBackup);

  Future<void> _onBackupImportRequested(
    SettingsBackupImportRequested event,
    Emitter<SettingsState> emit,
  ) async {
    if (state case final SettingsLoaded loaded) {
      emit(
        loaded.copyWith(
          isBusy: true,
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
          loaded.copyWith(isBusy: false, importProgress: null, importedCount: importedCount),
        (Success(data: BackupImportCancelled()), final SettingsLoaded loaded) => loaded.copyWith(
          isBusy: false,
          importProgress: null,
        ),
        (Failure(:final error), final SettingsLoaded loaded) => loaded.copyWith(
          isBusy: false,
          importProgress: null,
          error: error,
        ),
        _ => state,
      },
    );
  }

  Future<void> _runBusy<T>(
    Emitter<SettingsState> emit,
    Future<AppResult<T>> Function() action,
  ) async {
    if (state case final SettingsLoaded loaded) {
      emit(
        loaded.copyWith(
          isBusy: true,
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
        Success() => loaded.copyWith(isBusy: false, error: null),
        Failure(error: SyncPendingError()) => loaded.copyWith(
          isBusy: false,
          isSignOutBlocked: true,
        ),
        Failure(:final error) => loaded.copyWith(isBusy: false, error: error),
      });
    }
  }
}
