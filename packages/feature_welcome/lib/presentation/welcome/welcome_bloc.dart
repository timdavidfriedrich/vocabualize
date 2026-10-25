import 'package:core/error/app_result.dart';
import 'package:feature_welcome/presentation/welcome/welcome_event.dart';
import 'package:feature_welcome/presentation/welcome/welcome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/domain/repositories/account_repository.dart';

@injectable
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc(this._accountRepository) : super(const WelcomeIdle()) {
    on<WelcomeLocalUseChosen>(_onLocalUseChosen);
    on<WelcomeGoogleSignInChosen>(_onGoogleSignInChosen);
    on<WelcomeAccountConflictResolved>(_onAccountConflictResolved);
  }

  final AccountRepository _accountRepository;

  Future<void> _onLocalUseChosen(WelcomeLocalUseChosen event, Emitter<WelcomeState> emit) async {
    emit(const WelcomeBusy());
    emit(switch (await _accountRepository.continueWithoutAccount()) {
      Success() => const WelcomeIdle(),
      Failure(:final error) => WelcomeFailure(error: error),
    });
  }

  Future<void> _onGoogleSignInChosen(
    WelcomeGoogleSignInChosen event,
    Emitter<WelcomeState> emit,
  ) async {
    emit(const WelcomeBusy());
    emit(switch (await _accountRepository.signInWithGoogle()) {
      Success(data: SignedIn()) => const WelcomeIdle(),
      Success(data: final AccountConflict conflict) => WelcomeAccountConflict(conflict: conflict),
      Failure(:final error) => WelcomeFailure(error: error),
    });
  }

  Future<void> _onAccountConflictResolved(
    WelcomeAccountConflictResolved event,
    Emitter<WelcomeState> emit,
  ) async {
    emit(const WelcomeBusy());
    final result = await _accountRepository.resolveAccountConflict(
      keepsPreviousAccount: event.keepsPreviousAccount,
    );
    emit(switch (result) {
      Success() => const WelcomeIdle(),
      Failure(:final error) => WelcomeFailure(error: error),
    });
  }
}
