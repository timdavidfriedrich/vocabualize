import 'package:core/error/app_result.dart';
import 'package:feature_welcome/presentation/welcome_event.dart';
import 'package:feature_welcome/presentation/welcome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/repositories/account_repository.dart';

@injectable
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc(this._accountRepository) : super(const WelcomeIdle()) {
    on<WelcomeLocalUseChosen>(_onLocalUseChosen);
    on<WelcomeGoogleSignInChosen>(_onGoogleSignInChosen);
  }

  final AccountRepository _accountRepository;

  Future<void> _onLocalUseChosen(WelcomeLocalUseChosen event, Emitter<WelcomeState> emit) =>
      _choose(emit, _accountRepository.continueWithoutAccount);

  Future<void> _onGoogleSignInChosen(
    WelcomeGoogleSignInChosen event,
    Emitter<WelcomeState> emit,
  ) => _choose(emit, _accountRepository.signInWithGoogle);

  Future<void> _choose(
    Emitter<WelcomeState> emit,
    Future<AppResult<Account>> Function() action,
  ) async {
    emit(const WelcomeBusy());
    emit(switch (await action()) {
      Success() => const WelcomeIdle(),
      Failure(:final error) => WelcomeFailure(error: error),
    });
  }
}
