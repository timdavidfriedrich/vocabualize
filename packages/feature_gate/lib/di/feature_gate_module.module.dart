// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_gate/domain/use_cases/watch_gate_status_use_case.dart'
    as _i460;
import 'package:feature_gate/presentation/gate_cubit.dart' as _i396;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/app_config_repository.dart' as _i541;
import 'package:shared/domain/repositories/app_info_repository.dart' as _i328;

class FeatureGatePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i460.WatchGateStatusUseCase>(() => _i460.WatchGateStatusUseCase(
          gh<_i541.AppConfigRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
    gh.factory<_i396.GateCubit>(() => _i396.GateCubit(
          gh<_i460.WatchGateStatusUseCase>(),
          gh<_i541.AppConfigRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
  }
}
