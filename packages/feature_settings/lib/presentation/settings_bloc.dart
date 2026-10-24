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
          isSigningIn: false,
          signInError: null,
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
      emit(loaded.copyWith(isSigningIn: true, signInError: null));
    }
    final result = await _accountRepository.signInWithGoogle();
    if (state case final SettingsLoaded loaded) {
      emit(switch (result) {
        Success() => loaded.copyWith(isSigningIn: false, signInError: null),
        Failure(:final error) => loaded.copyWith(isSigningIn: false, signInError: error),
      });
    }
  }
}
