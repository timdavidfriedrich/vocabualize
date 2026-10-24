// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_welcome/presentation/language_selection/language_selection_bloc.dart'
    as _i165;
import 'package:feature_welcome/presentation/welcome/welcome_bloc.dart'
    as _i267;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;

class FeatureWelcomePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i165.LanguageSelectionBloc>(
        () => _i165.LanguageSelectionBloc(gh<_i0.SettingsRepository>()));
    gh.factory<_i267.WelcomeBloc>(
        () => _i267.WelcomeBloc(gh<_i923.AccountRepository>()));
  }
}
