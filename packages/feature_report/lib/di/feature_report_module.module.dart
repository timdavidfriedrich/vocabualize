// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_report/presentation/report_bloc.dart' as _i995;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/report_repository.dart' as _i522;

class FeatureReportPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i995.ReportBloc>(
        () => _i995.ReportBloc(gh<_i522.ReportRepository>()));
  }
}
