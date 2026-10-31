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
import 'package:shared/data/data_sources/activity_local_data_source.dart'
    as _i347;
import 'package:shared/data/data_sources/app_config_local_data_source.dart'
    as _i49;
import 'package:shared/data/data_sources/app_config_remote_data_source.dart'
    as _i223;
import 'package:shared/data/data_sources/app_info_data_source.dart' as _i394;
import 'package:shared/data/data_sources/auth_data_source.dart' as _i535;
import 'package:shared/data/data_sources/backup_archive_data_source.dart'
    as _i100;
import 'package:shared/data/data_sources/backup_file_data_source.dart' as _i460;
import 'package:shared/data/data_sources/calendar_data_source.dart' as _i4;
import 'package:shared/data/data_sources/clock_data_source.dart' as _i44;
import 'package:shared/data/data_sources/connectivity_data_source.dart'
    as _i154;
import 'package:shared/data/data_sources/database_session_data_source.dart'
    as _i862;
import 'package:shared/data/data_sources/device_data_source.dart' as _i931;
import 'package:shared/data/data_sources/external_link_data_source.dart'
    as _i515;
import 'package:shared/data/data_sources/image_file_data_source.dart' as _i532;
import 'package:shared/data/data_sources/image_processing_data_source.dart'
    as _i179;
import 'package:shared/data/data_sources/image_sync_data_source.dart' as _i61;
import 'package:shared/data/data_sources/image_transfer_data_source.dart'
    as _i28;
import 'package:shared/data/data_sources/local_import_data_source.dart'
    as _i843;
import 'package:shared/data/data_sources/notification_data_source.dart'
    as _i877;
import 'package:shared/data/data_sources/report_remote_data_source.dart'
    as _i320;
import 'package:shared/data/data_sources/service_access_data_source.dart'
    as _i228;
import 'package:shared/data/data_sources/setting_local_data_source.dart'
    as _i555;
import 'package:shared/data/data_sources/space_storage_data_source.dart'
    as _i753;
import 'package:shared/data/data_sources/stock_image_remote_data_source.dart'
    as _i317;
import 'package:shared/data/data_sources/sync_data_source.dart' as _i1034;
import 'package:shared/data/data_sources/tag_local_data_source.dart' as _i452;
import 'package:shared/data/data_sources/text_to_speech_data_source.dart'
    as _i820;
import 'package:shared/data/data_sources/translation_remote_data_source.dart'
    as _i906;
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart'
    as _i397;
import 'package:shared/data/repositories/account_repository_impl.dart' as _i631;
import 'package:shared/data/repositories/activity_repository_impl.dart'
    as _i351;
import 'package:shared/data/repositories/app_config_repository_impl.dart'
    as _i509;
import 'package:shared/data/repositories/app_info_repository_impl.dart'
    as _i1026;
import 'package:shared/data/repositories/backup_repository_impl.dart' as _i237;
import 'package:shared/data/repositories/clock_repository_impl.dart' as _i314;
import 'package:shared/data/repositories/connectivity_repository_impl.dart'
    as _i951;
import 'package:shared/data/repositories/external_link_repository_impl.dart'
    as _i22;
import 'package:shared/data/repositories/image_repository_impl.dart' as _i816;
import 'package:shared/data/repositories/language_repository_impl.dart'
    as _i850;
import 'package:shared/data/repositories/reminder_repository_impl.dart'
    as _i899;
import 'package:shared/data/repositories/report_repository_impl.dart' as _i296;
import 'package:shared/data/repositories/settings_repository_impl.dart'
    as _i921;
import 'package:shared/data/repositories/stock_image_repository_impl.dart'
    as _i645;
import 'package:shared/data/repositories/sync_repository_impl.dart' as _i368;
import 'package:shared/data/repositories/tag_repository_impl.dart' as _i453;
import 'package:shared/data/repositories/text_to_speech_repository_impl.dart'
    as _i905;
import 'package:shared/data/repositories/translation_repository_impl.dart'
    as _i542;
import 'package:shared/data/repositories/vocabulary_repository_impl.dart'
    as _i23;
import 'package:shared/di/serverpod_client_module.dart' as _i74;
import 'package:shared/domain/repositories/account_repository.dart' as _i923;
import 'package:shared/domain/repositories/activity_repository.dart' as _i503;
import 'package:shared/domain/repositories/app_config_repository.dart' as _i541;
import 'package:shared/domain/repositories/app_info_repository.dart' as _i328;
import 'package:shared/domain/repositories/backup_repository.dart' as _i152;
import 'package:shared/domain/repositories/clock_repository.dart' as _i946;
import 'package:shared/domain/repositories/connectivity_repository.dart'
    as _i689;
import 'package:shared/domain/repositories/external_link_repository.dart'
    as _i711;
import 'package:shared/domain/repositories/image_repository.dart' as _i204;
import 'package:shared/domain/repositories/language_repository.dart' as _i308;
import 'package:shared/domain/repositories/reminder_repository.dart' as _i821;
import 'package:shared/domain/repositories/report_repository.dart' as _i522;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;
import 'package:shared/domain/repositories/stock_image_repository.dart'
    as _i934;
import 'package:shared/domain/repositories/sync_repository.dart' as _i523;
import 'package:shared/domain/repositories/tag_repository.dart' as _i836;
import 'package:shared/domain/repositories/text_to_speech_repository.dart'
    as _i839;
import 'package:shared/domain/repositories/translation_repository.dart'
    as _i582;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;
import 'package:shared/domain/use_cases/watch_streak_use_case.dart' as _i76;
import 'package:shared/presentation/account/account_cubit.dart' as _i346;
import 'package:shared/presentation/connectivity/connectivity_cubit.dart'
    as _i855;
import 'package:shared/presentation/language_setup/language_setup_cubit.dart'
    as _i827;
import 'package:shared/presentation/preferences/preferences_cubit.dart'
    as _i218;
import 'package:shared/presentation/reminders/reminder_cubit.dart' as _i902;
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
    gh.lazySingleton<_i90.FlutterSecureStorage>(
        () => serverpodClientModule.secureStorage());
    gh.lazySingleton<_i90.ConnectivityMonitor>(
        () => serverpodClientModule.connectivityMonitor());
    gh.lazySingleton<_i931.DeviceDataSource>(
        () => _i931.DeviceDataSourceImpl());
    gh.factory<_i100.BackupArchiveDataSource>(
        () => const _i100.BackupArchiveDataSourceImpl());
    gh.factory<_i394.AppInfoDataSource>(
        () => const _i394.AppInfoDataSourceImpl());
    gh.lazySingleton<_i877.NotificationDataSource>(
        () => _i877.NotificationDataSourceImpl());
    gh.factory<_i179.ImageProcessingDataSource>(
        () => const _i179.ImageProcessingDataSourceImpl());
    gh.factory<_i4.CalendarDataSource>(
        () => const _i4.CalendarDataSourceImpl());
    gh.lazySingleton<_i49.AppConfigLocalDataSource>(
        () => _i49.AppConfigLocalDataSourceImpl());
    gh.factory<_i821.ReminderRepository>(
        () => _i899.ReminderRepositoryImpl(gh<_i877.NotificationDataSource>()));
    gh.lazySingleton<_i820.TextToSpeechDataSource>(
        () => _i820.TextToSpeechDataSourceImpl());
    gh.factory<_i753.SpaceStorageDataSource>(
        () => const _i753.SpaceStorageDataSourceImpl());
    gh.factory<_i515.ExternalLinkDataSource>(
        () => const _i515.ExternalLinkDataSourceImpl());
    gh.lazySingleton<_i1040.Client>(() => serverpodClientModule.client(
          gh<_i90.FlutterAuthSessionManager>(),
          gh<_i90.ConnectivityMonitor>(),
        ));
    gh.factory<_i328.AppInfoRepository>(
        () => _i1026.AppInfoRepositoryImpl(gh<_i394.AppInfoDataSource>()));
    gh.factory<_i711.ExternalLinkRepository>(() =>
        _i22.ExternalLinkRepositoryImpl(gh<_i515.ExternalLinkDataSource>()));
    gh.factory<_i28.ImageTransferDataSource>(
        () => _i28.ImageTransferDataSourceImpl(
              gh<_i1040.Client>(),
              gh<_i361.Dio>(),
            ));
    gh.factory<_i460.BackupFileDataSource>(
        () => const _i460.BackupFileDataSourceImpl());
    gh.factory<_i154.ConnectivityDataSource>(
        () => const _i154.ConnectivityDataSourceImpl());
    gh.factory<_i320.ReportRemoteDataSource>(
        () => _i320.ReportRemoteDataSourceImpl(gh<_i1040.Client>()));
    gh.factory<_i223.AppConfigRemoteDataSource>(
        () => _i223.AppConfigRemoteDataSourceImpl(gh<_i1040.Client>()));
    gh.factory<_i204.ImageRepository>(() => _i816.ImageRepositoryImpl(
          gh<_i179.ImageProcessingDataSource>(),
          gh<_i28.ImageTransferDataSource>(),
        ));
    gh.lazySingleton<_i228.ServiceAccessDataSource>(
        () => _i228.ServiceAccessDataSourceImpl(
              gh<_i1040.Client>(),
              gh<_i90.FlutterAuthSessionManager>(),
              gh<_i90.FlutterSecureStorage>(),
            ));
    gh.factory<_i689.ConnectivityRepository>(() =>
        _i951.ConnectivityRepositoryImpl(gh<_i154.ConnectivityDataSource>()));
    gh.lazySingleton<_i44.ClockDataSource>(() => _i44.ClockDataSourceImpl(
          gh<_i1040.Client>(),
          gh<_i1040.ConnectivityMonitor>(),
        )..listenToEvents());
    gh.factory<_i839.TextToSpeechRepository>(() =>
        _i905.TextToSpeechRepositoryImpl(gh<_i820.TextToSpeechDataSource>()));
    gh.factory<_i535.AuthDataSource>(() => _i535.AuthDataSourceImpl(
          gh<_i1040.Client>(),
          gh<_i90.FlutterAuthSessionManager>(),
        ));
    gh.factory<_i541.AppConfigRepository>(() => _i509.AppConfigRepositoryImpl(
          gh<_i223.AppConfigRemoteDataSource>(),
          gh<_i49.AppConfigLocalDataSource>(),
        ));
    gh.factory<_i906.TranslationRemoteDataSource>(
        () => _i906.TranslationRemoteDataSourceImpl(
              gh<_i1040.Client>(),
              gh<_i228.ServiceAccessDataSource>(),
            ));
    gh.factory<_i855.ConnectivityCubit>(() => _i855.ConnectivityCubit(
          gh<_i689.ConnectivityRepository>(),
          gh<_i328.AppInfoRepository>(),
        ));
    gh.factory<_i317.StockImageRemoteDataSource>(
        () => _i317.StockImageRemoteDataSourceImpl(
              gh<_i1040.Client>(),
              gh<_i228.ServiceAccessDataSource>(),
            ));
    gh.factory<_i946.ClockRepository>(
        () => _i314.ClockRepositoryImpl(gh<_i44.ClockDataSource>()));
    gh.lazySingleton<_i1034.SyncDataSource>(() => _i1034.SyncDataSourceImpl(
          gh<_i1040.Client>(),
          gh<_i654.ConnectivityMonitor>(),
          gh<_i753.SpaceStorageDataSource>(),
          gh<_i44.ClockDataSource>(),
        ));
    gh.lazySingleton<_i862.DatabaseSessionDataSource>(
        () => _i862.DatabaseSessionDataSourceImpl(
              gh<_i1040.Client>(),
              gh<_i44.ClockDataSource>(),
              gh<_i753.SpaceStorageDataSource>(),
            ));
    gh.factory<_i582.TranslationRepository>(() =>
        _i542.TranslationRepositoryImpl(
            gh<_i906.TranslationRemoteDataSource>()));
    gh.factory<_i452.TagLocalDataSource>(() =>
        _i452.TagLocalDataSourceImpl(gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i934.StockImageRepository>(() =>
        _i645.StockImageRepositoryImpl(gh<_i317.StockImageRemoteDataSource>()));
    gh.factory<_i397.VocabularyLocalDataSource>(() =>
        _i397.VocabularyLocalDataSourceImpl(
            gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i347.ActivityLocalDataSource>(() =>
        _i347.ActivityLocalDataSourceImpl(
            gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i555.SettingLocalDataSource>(() =>
        _i555.SettingLocalDataSourceImpl(
            gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i0.SettingsRepository>(
        () => _i921.SettingsRepositoryImpl(gh<_i555.SettingLocalDataSource>()));
    gh.factory<_i522.ReportRepository>(() => _i296.ReportRepositoryImpl(
          gh<_i320.ReportRemoteDataSource>(),
          gh<_i394.AppInfoDataSource>(),
          gh<_i555.SettingLocalDataSource>(),
        ));
    gh.factory<_i503.ActivityRepository>(() => _i351.ActivityRepositoryImpl(
          gh<_i347.ActivityLocalDataSource>(),
          gh<_i4.CalendarDataSource>(),
        ));
    gh.lazySingleton<_i532.ImageFileDataSource>(
        () => _i532.ImageFileDataSourceImpl(
              gh<_i862.DatabaseSessionDataSource>(),
              gh<_i753.SpaceStorageDataSource>(),
            ));
    gh.lazySingleton<_i61.ImageSyncDataSource>(
        () => _i61.ImageSyncDataSourceImpl(
              gh<_i1034.SyncDataSource>(),
              gh<_i862.DatabaseSessionDataSource>(),
              gh<_i532.ImageFileDataSource>(),
              gh<_i28.ImageTransferDataSource>(),
            ));
    gh.factory<_i843.LocalImportDataSource>(() =>
        _i843.LocalImportDataSourceImpl(gh<_i862.DatabaseSessionDataSource>()));
    gh.factory<_i208.VocabularyRepository>(() => _i23.VocabularyRepositoryImpl(
          gh<_i397.VocabularyLocalDataSource>(),
          gh<_i532.ImageFileDataSource>(),
          gh<_i931.DeviceDataSource>(),
        ));
    gh.factory<_i308.LanguageRepository>(() => _i850.LanguageRepositoryImpl(
          gh<_i555.SettingLocalDataSource>(),
          gh<_i394.AppInfoDataSource>(),
        ));
    gh.factory<_i836.TagRepository>(() => _i453.TagRepositoryImpl(
          gh<_i452.TagLocalDataSource>(),
          gh<_i532.ImageFileDataSource>(),
        ));
    gh.factory<_i218.PreferencesCubit>(
        () => _i218.PreferencesCubit(gh<_i0.SettingsRepository>()));
    gh.factory<_i523.SyncRepository>(() => _i368.SyncRepositoryImpl(
          gh<_i1034.SyncDataSource>(),
          gh<_i61.ImageSyncDataSource>(),
        ));
    gh.lazySingleton<_i923.AccountRepository>(() => _i631.AccountRepositoryImpl(
          gh<_i535.AuthDataSource>(),
          gh<_i862.DatabaseSessionDataSource>(),
          gh<_i753.SpaceStorageDataSource>(),
          gh<_i532.ImageFileDataSource>(),
          gh<_i28.ImageTransferDataSource>(),
          gh<_i843.LocalImportDataSource>(),
          gh<_i555.SettingLocalDataSource>(),
          gh<_i1034.SyncDataSource>(),
          gh<_i61.ImageSyncDataSource>(),
          gh<_i228.ServiceAccessDataSource>(),
          gh<_i931.DeviceDataSource>(),
        ));
    gh.factory<_i765.SyncStatusCubit>(
        () => _i765.SyncStatusCubit(gh<_i523.SyncRepository>()));
    gh.factory<_i152.BackupRepository>(() => _i237.BackupRepositoryImpl(
          gh<_i862.DatabaseSessionDataSource>(),
          gh<_i843.LocalImportDataSource>(),
          gh<_i532.ImageFileDataSource>(),
          gh<_i179.ImageProcessingDataSource>(),
          gh<_i100.BackupArchiveDataSource>(),
          gh<_i460.BackupFileDataSource>(),
          gh<_i555.SettingLocalDataSource>(),
        ));
    gh.factory<_i76.WatchStreakUseCase>(
        () => _i76.WatchStreakUseCase(gh<_i503.ActivityRepository>()));
    gh.factory<_i827.LanguageSetupCubit>(
        () => _i827.LanguageSetupCubit(gh<_i308.LanguageRepository>()));
    gh.factory<_i346.AccountCubit>(
        () => _i346.AccountCubit(gh<_i923.AccountRepository>()));
    gh.factory<_i902.ReminderCubit>(() => _i902.ReminderCubit(
          gh<_i821.ReminderRepository>(),
          gh<_i0.SettingsRepository>(),
          gh<_i208.VocabularyRepository>(),
          gh<_i308.LanguageRepository>(),
          gh<_i76.WatchStreakUseCase>(),
        ));
  }
}

class _$ServerpodClientModule extends _i74.ServerpodClientModule {}
