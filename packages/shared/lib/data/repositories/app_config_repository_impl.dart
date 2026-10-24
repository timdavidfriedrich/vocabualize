import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_config_local_data_source.dart';
import 'package:shared/data/data_sources/app_config_remote_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/app_config_mappers.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';

@Injectable(as: AppConfigRepository)
class const AppConfigRepositoryImpl(
  final AppConfigRemoteDataSource _remoteDataSource,
  final AppConfigLocalDataSource _localDataSource,
) implements AppConfigRepository {
  @override
  Stream<AppResult<AppConfig>> watchConfig() {
    return _localDataSource
        .watchCache()
        .map((config) => config?.toAppConfig() ?? defaultAppConfig)
        .toAppResult();
  }

  @override
  Future<AppResult<()>> refresh() async {
    try {
      await _localDataSource.writeCache(await _remoteDataSource.fetchConfig());
      return const Success(());
    } on Object {
      return const Failure(ConnectionError());
    }
  }
}
