import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_gate/domain/use_cases/watch_gate_status_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/clock_status.dart';
import 'package:shared/domain/entities/gate_status.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';
import 'package:shared/domain/repositories/clock_repository.dart';

@injectable
class GateCubit extends Cubit<GateStatus> {
  GateCubit(
    this._watchGateStatus,
    this._clockRepository,
    this._appConfigRepository,
    this._appInfoRepository,
  ) : super(const GateOpen());

  final WatchGateStatusUseCase _watchGateStatus;
  final ClockRepository _clockRepository;
  final AppConfigRepository _appConfigRepository;
  final AppInfoRepository _appInfoRepository;
  StreamSubscription<AppResult<GateStatus>>? _configSubscription;
  StreamSubscription<AppResult<ClockStatus>>? _clockSubscription;
  GateStatus _configStatus = const GateOpen();
  ClockStatus _clockStatus = ClockStatus.unknown;

  void start() {
    _configSubscription ??= _watchGateStatus().listen((result) {
      if (result case Success(:final data)) {
        _configStatus = data;
        emit(_combinedStatus());
      }
    });
    _clockSubscription ??= _clockRepository.watchClockStatus().listen((result) {
      _clockStatus = switch (result) {
        Success(:final data) => data,
        Failure() => ClockStatus.unknown,
      };
      emit(_combinedStatus());
    });
    unawaited(refresh());
  }

  Future<void> refresh() async {
    await _appConfigRepository.refresh();
  }

  Future<void> openStore() async {
    await _appInfoRepository.openStoreListing();
  }

  Future<void> openDateSettings() async {
    await _appInfoRepository.openDateSettings();
  }

  GateStatus _combinedStatus() => switch ((_configStatus, _clockStatus)) {
    (GateOpen(), ClockStatus.wrong) => const GateClockWrong(),
    (final configStatus, _) => configStatus,
  };

  @override
  Future<void> close() async {
    await _configSubscription?.cancel();
    await _clockSubscription?.cancel();
    return super.close();
  }
}
