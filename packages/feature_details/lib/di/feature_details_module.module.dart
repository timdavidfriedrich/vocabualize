// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_details/presentation/details_bloc.dart' as _i880;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;

class FeatureDetailsPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i880.DetailsBloc>(() => _i880.DetailsBloc(gh<_i208.VocabularyRepository>()));
  }
}
