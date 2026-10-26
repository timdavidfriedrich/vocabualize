// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_scan/data/repositories/image_labeling_repository_impl.dart'
    as _i345;
import 'package:feature_scan/domain/repositories/image_labeling_repository.dart'
    as _i901;
import 'package:feature_scan/presentation/scan_bloc.dart' as _i710;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/data/data_sources/ai_remote_data_source.dart' as _i395;
import 'package:shared/data/data_sources/image_processing_data_source.dart'
    as _i179;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/app_info_repository.dart' as _i328;
import 'package:shared/domain/repositories/image_repository.dart' as _i204;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;

class FeatureScanPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i901.ImageLabelingRepository>(
        () => _i345.ImageLabelingRepositoryImpl(
              gh<_i179.ImageProcessingDataSource>(),
              gh<_i395.AiRemoteDataSource>(),
            ));
    gh.factory<_i710.ScanBloc>(() => _i710.ScanBloc(
          gh<_i204.ImageRepository>(),
          gh<_i901.ImageLabelingRepository>(),
          gh<_i923.AccountRepository>(),
          gh<_i0.SettingsRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
  }
}
