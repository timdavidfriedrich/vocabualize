// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core/di/core_module.module.dart' as _i8;
import 'package:feature_collections/di/feature_collections_module.module.dart'
    as _i285;
import 'package:feature_details/di/feature_details_module.module.dart' as _i159;
import 'package:feature_gate/di/feature_gate_module.module.dart' as _i188;
import 'package:feature_home/di/feature_home_module.module.dart' as _i606;
import 'package:feature_practice/di/feature_practice_module.module.dart'
    as _i391;
import 'package:feature_report/di/feature_report_module.module.dart' as _i123;
import 'package:feature_scan/di/feature_scan_module.module.dart' as _i767;
import 'package:feature_settings/di/feature_settings_module.module.dart'
    as _i924;
import 'package:feature_welcome/di/feature_welcome_module.module.dart' as _i276;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/di/shared_module.module.dart' as _i826;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:vocabualize/src/navigation/navigation_router.dart' as _i2;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    await _i8.CorePackageModule().init(gh);
    await _i826.SharedPackageModule().init(gh);
    await _i606.FeatureHomePackageModule().init(gh);
    await _i276.FeatureWelcomePackageModule().init(gh);
    await _i159.FeatureDetailsPackageModule().init(gh);
    await _i391.FeaturePracticePackageModule().init(gh);
    await _i285.FeatureCollectionsPackageModule().init(gh);
    await _i767.FeatureScanPackageModule().init(gh);
    await _i924.FeatureSettingsPackageModule().init(gh);
    await _i123.FeatureReportPackageModule().init(gh);
    await _i188.FeatureGatePackageModule().init(gh);
    gh.lazySingleton<_i2.NavigationRouter>(
      () =>
          _i2.NavigationRouter(gh<_i923.AccountRepository>())
            ..listenToAuthStatus(),
    );
    return this;
  }
}
