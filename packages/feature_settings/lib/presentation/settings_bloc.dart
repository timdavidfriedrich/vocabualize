import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/repositories/account_repository.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._accountRepository) : super(const SettingsLoading()) {
    on<SettingsStarted>(_onStarted);
    on<SettingsGoogleSignInRequested>(_onGoogleSignInRequested);
    on<SettingsSignOutRequested>(_onSignOutRequested);
    on<SettingsSignOutDismissed>(_onSignOutDismissed);
  }

  final AccountRepository _accountRepository;

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
          error: null,
        ),
        _ => state,
      },
    );
  }

  Future<void> _onGoogleSignInRequested(
    SettingsGoogleSignInRequested event,
    Emitter<SettingsState> emit,
  ) => _runBusy(emit, _accountRepository.signInWithGoogle);

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

  Future<void> _runBusy<T>(
    Emitter<SettingsState> emit,
    Future<AppResult<T>> Function() action,
  ) async {
    if (state case final SettingsLoaded loaded) {
      emit(loaded.copyWith(isBusy: true, isSignOutBlocked: false, error: null));
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
