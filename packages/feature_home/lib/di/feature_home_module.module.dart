// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_home/data/data_sources/article_local_data_source.dart' as _i1030;
import 'package:feature_home/data/repositories/article_repository_impl.dart' as _i901;
import 'package:feature_home/domain/repositories/article_repository.dart' as _i782;
import 'package:feature_home/presentation/article_detail/article_detail_bloc.dart' as _i847;
import 'package:feature_home/presentation/home/home_bloc.dart' as _i864;
import 'package:injectable/injectable.dart' as _i526;

class FeatureHomePackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i1030.ArticleLocalDataSource>(() => const _i1030.ArticleLocalDataSourceImpl());
    gh.factory<_i782.ArticleRepository>(
      () => _i901.ArticleRepositoryImpl(gh<_i1030.ArticleLocalDataSource>()),
    );
    gh.factoryParam<_i847.ArticleDetailBloc, String, dynamic>(
      (
        _articleId,
        _,
      ) => _i847.ArticleDetailBloc(
        gh<_i782.ArticleRepository>(),
        _articleId,
      ),
    );
    gh.factory<_i864.HomeBloc>(() => _i864.HomeBloc(gh<_i782.ArticleRepository>()));
  }
}
