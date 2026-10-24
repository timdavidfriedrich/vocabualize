import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_gate/domain/use_cases/watch_gate_status_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/gate_status.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';

@injectable
class GateCubit extends Cubit<GateStatus> {
  GateCubit(this._watchGateStatus, this._appConfigRepository, this._appInfoRepository)
    : super(const GateOpen());

  final WatchGateStatusUseCase _watchGateStatus;
  final AppConfigRepository _appConfigRepository;
  final AppInfoRepository _appInfoRepository;
  StreamSubscription<AppResult<GateStatus>>? _subscription;

  void start() {
    _subscription ??= _watchGateStatus().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
    unawaited(refresh());
  }

  Future<void> refresh() async {
    await _appConfigRepository.refresh();
  }

  Future<void> openStore() async {
    await _appInfoRepository.openStoreListing();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
