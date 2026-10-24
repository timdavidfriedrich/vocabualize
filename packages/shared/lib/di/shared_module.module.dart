// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:dio/dio.dart' as _i361;
import 'package:injectable/injectable.dart' as _i526;
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    as _i90;
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart'
    as _i654;
import 'package:shared/data/data_sources/app_config_local_data_source.dart'
    as _i49;
import 'package:shared/data/data_sources/app_config_remote_data_source.dart'
    as _i223;
import 'package:shared/data/data_sources/app_info_data_source.dart' as _i394;
import 'package:shared/data/data_sources/auth_data_source.dart' as _i535;
import 'package:shared/data/data_sources/backup_archive_data_source.dart'
    as _i100;
import 'package:shared/data/data_sources/backup_file_data_source.dart' as _i460;
import 'package:shared/data/data_sources/database_session_data_source.dart'
    as _i862;
import 'package:shared/data/data_sources/image_file_data_source.dart' as _i532;
import 'package:shared/data/data_sources/image_processing_data_source.dart'
    as _i179;
import 'package:shared/data/data_sources/image_sync_data_source.dart' as _i61;
import 'package:shared/data/data_sources/image_transfer_data_source.dart'
    as _i28;
import 'package:shared/data/data_sources/local_import_data_source.dart'
    as _i843;
import 'package:shared/data/data_sources/sync_data_source.dart' as _i1034;
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart'
    as _i397;
import 'package:shared/data/repositories/account_repository_impl.dart' as _i631;
import 'package:shared/data/repositories/app_config_repository_impl.dart'
    as _i509;
import 'package:shared/data/repositories/app_info_repository_impl.dart'
    as _i1026;
import 'package:shared/data/repositories/backup_repository_impl.dart' as _i237;
import 'package:shared/data/repositories/image_repository_impl.dart' as _i816;
import 'package:shared/data/repositories/sync_repository_impl.dart' as _i368;
import 'package:shared/data/repositories/vocabulary_repository_impl.dart'
    as _i22;
import 'package:shared/di/serverpod_client_module.dart' as _i74;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/app_config_repository.dart' as _i541;
import 'package:shared/domain/repositories/app_info_repository.dart' as _i328;
import 'package:shared/domain/repositories/backup_repository.dart' as _i152;
import 'package:shared/domain/repositories/image_repository.dart' as _i204;
import 'package:shared/domain/repositories/sync_repository.dart' as _i523;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;
import 'package:shared/presentation/sync_status/sync_status_cubit.dart'
    as _i765;
import 'package:vocabualize_client/vocabualize_client.dart' as _i1040;

class SharedPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final serverpodClientModule = _$ServerpodClientModule();
    gh.lazySingleton<_i90.FlutterAuthSessionManager>(
        () => serverpodClientModule.sessionManager());
    gh.lazySingleton<_i90.ConnectivityMonitor>(
        () => serverpodClientModule.connectivityMonitor());
    gh.factory<_i100.BackupArchiveDataSource>(
        () => const _i100.BackupArchiveDataSourceImpl());
    gh.factory<_i394.AppInfoDataSource>(
        () => const _i394.AppInfoDataSourceImpl());
    gh.factory<_i179.ImageProcessingDataSource>(
        () => const _i179.ImageProcessingDataSourceImpl());
    gh.lazySingleton<_i49.AppConfigLocalDataSource>(
        () => _i49.AppConfigLocalDataSourceImpl());
    gh.lazySingleton<_i1040.Client>(() => serverpodClientModule.client(
          gh<_i90.FlutterAuthSessionManager>(),
          gh<_i90.ConnectivityMonitor>(),
        ));
    gh.factory<_i328.AppInfoRepository>(
        () => _i1026.AppInfoRepositoryImpl(gh<_i394.AppInfoDataSource>()));
    gh.factory<_i28.ImageTransferDataSource>(
        () => _i28.ImageTransferDataSourceImpl(
              gh<_i1040.Client>(),
              gh<_i361.Dio>(),
            ));
    gh.factory<_i460.BackupFileDataSource>(
        () => const _i460.BackupFileDataSourceImpl());
    gh.lazySingleton<_i1034.SyncDataSource>(() => _i1034.SyncDataSourceImpl(
          gh<_i1040.Client>(),
          gh<_i654.ConnectivityMonitor>(),
        ));
    gh.factory<_i223.AppConfigRemoteDataSource>(
        () => _i223.AppConfigRemoteDataSourceImpl(gh<_i1040.Client>()));
    gh.lazySingleton<_i862.DatabaseSessionDataSource>(
        () => _i862.DatabaseSessionDataSourceImpl(gh<_i1040.Client>()));
    gh.factory<_i204.ImageRepository>(
        () => _i816.ImageRepositoryImpl(gh<_i179.ImageProcessingDataSource>()));
    gh.factory<_i843.LocalImportDataSource>(() =>
        _i843.LocalImportDataSourceImpl(gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i535.AuthDataSource>(() => _i535.AuthDataSourceImpl(
          gh<_i1040.Client>(),
          gh<_i90.FlutterAuthSessionManager>(),
        ));
    gh.factory<_i541.AppConfigRepository>(() => _i509.AppConfigRepositoryImpl(
          gh<_i223.AppConfigRemoteDataSource>(),
          gh<_i49.AppConfigLocalDataSource>(),
        ));
    gh.factory<_i523.SyncRepository>(
        () => _i368.SyncRepositoryImpl(gh<_i1034.SyncDataSource>()));
    gh.factory<_i397.VocabularyLocalDataSource>(() =>
        _i397.VocabularyLocalDataSourceImpl(
            gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i765.SyncStatusCubit>(
        () => _i765.SyncStatusCubit(gh<_i523.SyncRepository>()));
    gh.lazySingleton<_i532.ImageFileDataSource>(() =>
        _i532.ImageFileDataSourceImpl(gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i208.VocabularyRepository>(() => _i22.VocabularyRepositoryImpl(
          gh<_i397.VocabularyLocalDataSource>(),
          gh<_i532.ImageFileDataSource>(),
        ));
    gh.factory<_i152.BackupRepository>(() => _i237.BackupRepositoryImpl(
          gh<_i862.DatabaseSessionDataSource>(),
          gh<_i843.LocalImportDataSource>(),
          gh<_i532.ImageFileDataSource>(),
          gh<_i179.ImageProcessingDataSource>(),
          gh<_i100.BackupArchiveDataSource>(),
          gh<_i460.BackupFileDataSource>(),
        ));
    gh.lazySingleton<_i61.ImageSyncDataSource>(
        () => _i61.ImageSyncDataSourceImpl(
              gh<_i1034.SyncDataSource>(),
              gh<_i532.ImageFileDataSource>(),
              gh<_i28.ImageTransferDataSource>(),
            ));
    gh.lazySingleton<_i923.AccountRepository>(() => _i631.AccountRepositoryImpl(
          gh<_i535.AuthDataSource>(),
          gh<_i862.DatabaseSessionDataSource>(),
          gh<_i843.LocalImportDataSource>(),
          gh<_i1034.SyncDataSource>(),
          gh<_i61.ImageSyncDataSource>(),
        ));
  }
}

class _$ServerpodClientModule extends _i74.ServerpodClientModule {}
