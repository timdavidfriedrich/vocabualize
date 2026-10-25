import 'package:core/error/app_result.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';
import 'package:shared/domain/repositories/sync_repository.dart';

@injectable
class WaitForDataCubit extends Cubit<WaitForDataState> {
  WaitForDataCubit(this._syncRepository, this._accountRepository, this._appInfoRepository)
    : super(const WaitForDataState(isBusy: false, error: null));

  final SyncRepository _syncRepository;
  final AccountRepository _accountRepository;
  final AppInfoRepository _appInfoRepository;

  void retry() {
    if (_syncRepository.retryInitialSync() case Failure(:final error)) {
      emit(state.copyWith(error: error));
    }
  }

  Future<void> signIn() async {
    if (state.isBusy) return;
    emit(state.copyWith(isBusy: true, error: null));
    final result = await _accountRepository.signInWithGoogle();
    emit(switch (result) {
      Success() => state.copyWith(isBusy: false),
      Failure(:final error) => state.copyWith(isBusy: false, error: error),
    });
  }

  Future<void> openDateSettings() async {
    if (await _appInfoRepository.openDateSettings() case Failure(:final error)) {
      emit(state.copyWith(error: error));
    }
  }

  Future<void> openStore() async {
    if (await _appInfoRepository.openStoreListing() case Failure(:final error)) {
      emit(state.copyWith(error: error));
    }
  }
}
