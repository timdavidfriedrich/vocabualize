import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';

@injectable
class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit(this._connectivityRepository, this._appInfoRepository) : super(true);

  final ConnectivityRepository _connectivityRepository;
  final AppInfoRepository _appInfoRepository;
  StreamSubscription<AppResult<bool>>? _subscription;

  void start() {
    _subscription ??= _connectivityRepository.watchIsConnected().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
  }

  Future<void> openInternetSettings() async {
    await _appInfoRepository.openInternetSettings();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
