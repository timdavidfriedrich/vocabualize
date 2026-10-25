// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_details/data/data_sources/image_picker_data_source.dart'
    as _i637;
import 'package:feature_details/data/repositories/image_picker_repository_impl.dart'
    as _i417;
import 'package:feature_details/domain/repositories/image_picker_repository.dart'
    as _i84;
import 'package:feature_details/domain/use_cases/pick_image_use_case.dart'
    as _i831;
import 'package:feature_details/presentation/details_bloc.dart' as _i880;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/external_link_repository.dart'
    as _i711;
import 'package:shared/domain/repositories/image_repository.dart' as _i204;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;
import 'package:shared/domain/repositories/stock_image_repository.dart'
    as _i934;
import 'package:shared/domain/repositories/translation_repository.dart'
    as _i582;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;

class FeatureDetailsPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i637.ImagePickerDataSource>(
        () => const _i637.ImagePickerDataSourceImpl());
    gh.factory<_i84.ImagePickerRepository>(() =>
        _i417.ImagePickerRepositoryImpl(gh<_i637.ImagePickerDataSource>()));
    gh.factory<_i831.PickImageUseCase>(() => _i831.PickImageUseCase(
          gh<_i84.ImagePickerRepository>(),
          gh<_i204.ImageRepository>(),
        ));
    gh.factory<_i880.DetailsBloc>(() => _i880.DetailsBloc(
          gh<_i208.VocabularyRepository>(),
          gh<_i0.SettingsRepository>(),
          gh<_i923.AccountRepository>(),
          gh<_i582.TranslationRepository>(),
          gh<_i934.StockImageRepository>(),
          gh<_i204.ImageRepository>(),
          gh<_i711.ExternalLinkRepository>(),
          gh<_i831.PickImageUseCase>(),
        ));
  }
}
