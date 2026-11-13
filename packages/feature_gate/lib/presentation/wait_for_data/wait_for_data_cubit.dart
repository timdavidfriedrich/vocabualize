import 'package:core/error/app_result.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/sync_repository.dart';

const _idle = WaitForDataIdle(accountConflict: null, error: null);

@injectable
class WaitForDataCubit extends Cubit<WaitForDataState> {
  WaitForDataCubit(this._syncRepository, this._accountRepository) : super(_idle);

  final SyncRepository _syncRepository;
  final AccountRepository _accountRepository;

  void retry() {
    if (state case WaitForDataBusy()) return;
    emit(_idle);
    if (_syncRepository.retryInitialSync() case Failure(:final error)) {
      emit(WaitForDataIdle(accountConflict: null, error: error));
    }
  }

  Future<void> signIn() async {
    if (state case WaitForDataBusy()) return;
    emit(const WaitForDataBusy());
    final result = await _accountRepository.signInWithGoogle();
    emit(switch (result) {
      Success(data: SignedIn() || SignInCancelled()) => _idle,
      Success(data: final AccountConflict conflict) => WaitForDataIdle(
        accountConflict: conflict,
        error: null,
      ),
      Failure(:final error) => WaitForDataIdle(accountConflict: null, error: error),
    });
  }

  Future<void> resolveAccountConflict({required bool keepsPreviousAccount}) async {
    emit(const WaitForDataBusy());
    final result = await _accountRepository.resolveAccountConflict(
      keepsPreviousAccount: keepsPreviousAccount,
    );
    emit(switch (result) {
      Success() => _idle,
      Failure(:final error) => WaitForDataIdle(accountConflict: null, error: error),
    });
  }
}
