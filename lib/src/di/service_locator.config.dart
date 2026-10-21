// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core/di/core_module.module.dart' as _i8;
import 'package:feature_home/di/feature_home_module.module.dart' as _i606;
import 'package:feature_welcome/di/feature_welcome_module.module.dart' as _i276;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/di/shared_module.module.dart' as _i826;
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
    gh.singleton<_i2.NavigationRouter>(() => _i2.NavigationRouter());
    return this;
  }
}
