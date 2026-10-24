// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart' as _i90;
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart' as _i654;
import 'package:shared/data/data_sources/auth_data_source.dart' as _i535;
import 'package:shared/data/data_sources/database_session_data_source.dart' as _i862;
import 'package:shared/data/data_sources/local_import_data_source.dart' as _i843;
import 'package:shared/data/data_sources/sync_data_source.dart' as _i1034;
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart' as _i397;
import 'package:shared/data/repositories/account_repository_impl.dart' as _i631;
import 'package:shared/data/repositories/sync_repository_impl.dart' as _i368;
import 'package:shared/data/repositories/vocabulary_repository_impl.dart' as _i22;
import 'package:shared/di/serverpod_client_module.dart' as _i74;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/sync_repository.dart' as _i523;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;
import 'package:shared/presentation/sync_status/sync_status_cubit.dart' as _i765;
import 'package:vocabualize_client/vocabualize_client.dart' as _i1040;

class SharedPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final serverpodClientModule = _$ServerpodClientModule();
    gh.lazySingleton<_i90.FlutterAuthSessionManager>(() => serverpodClientModule.sessionManager());
    gh.lazySingleton<_i90.ConnectivityMonitor>(() => serverpodClientModule.connectivityMonitor());
    gh.lazySingleton<_i1040.Client>(
      () => serverpodClientModule.client(
        gh<_i90.FlutterAuthSessionManager>(),
        gh<_i90.ConnectivityMonitor>(),
      ),
    );
    gh.lazySingleton<_i1034.SyncDataSource>(
      () => _i1034.SyncDataSourceImpl(
        gh<_i1040.Client>(),
        gh<_i654.ConnectivityMonitor>(),
      ),
    );
    gh.lazySingleton<_i862.DatabaseSessionDataSource>(
      () => _i862.DatabaseSessionDataSourceImpl(gh<_i1040.Client>()),
    );
    gh.factory<_i843.LocalImportDataSource>(
      () => _i843.LocalImportDataSourceImpl(gh<_i862.DatabaseSessionDataSource>()),
    );
    gh.factory<_i535.AuthDataSource>(
      () => _i535.AuthDataSourceImpl(
        gh<_i1040.Client>(),
        gh<_i90.FlutterAuthSessionManager>(),
      ),
    );
    gh.factory<_i523.SyncRepository>(() => _i368.SyncRepositoryImpl(gh<_i1034.SyncDataSource>()));
    gh.factory<_i397.VocabularyLocalDataSource>(
      () => _i397.VocabularyLocalDataSourceImpl(gh<_i862.DatabaseSessionDataSource>()),
    );
    gh.factory<_i765.SyncStatusCubit>(() => _i765.SyncStatusCubit(gh<_i523.SyncRepository>()));
    gh.factory<_i208.VocabularyRepository>(
      () => _i22.VocabularyRepositoryImpl(gh<_i397.VocabularyLocalDataSource>()),
    );
    gh.lazySingleton<_i923.AccountRepository>(
      () => _i631.AccountRepositoryImpl(
        gh<_i535.AuthDataSource>(),
        gh<_i862.DatabaseSessionDataSource>(),
        gh<_i843.LocalImportDataSource>(),
        gh<_i1034.SyncDataSource>(),
      ),
    );
  }
}

class _$ServerpodClientModule extends _i74.ServerpodClientModule {}
