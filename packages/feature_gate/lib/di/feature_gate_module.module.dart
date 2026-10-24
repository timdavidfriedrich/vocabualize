// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_gate/domain/use_cases/watch_gate_status_use_case.dart'
    as _i460;
import 'package:feature_gate/presentation/gate/gate_cubit.dart' as _i357;
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_cubit.dart'
    as _i822;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/app_config_repository.dart' as _i541;
import 'package:shared/domain/repositories/app_info_repository.dart' as _i328;
import 'package:shared/domain/repositories/sync_repository.dart' as _i523;

class FeatureGatePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i822.WaitForDataCubit>(() => _i822.WaitForDataCubit(
          gh<_i523.SyncRepository>(),
          gh<_i923.AccountRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
    gh.factory<_i460.WatchGateStatusUseCase>(() => _i460.WatchGateStatusUseCase(
          gh<_i541.AppConfigRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
    gh.factory<_i357.GateCubit>(() => _i357.GateCubit(
          gh<_i460.WatchGateStatusUseCase>(),
          gh<_i541.AppConfigRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
  }
}
