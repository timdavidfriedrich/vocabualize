import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_config_remote_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

@Injectable(as: AppConfigRemoteDataSource)
class const AppConfigRemoteDataSourceImpl(
  final Client _client,
) implements AppConfigRemoteDataSource {
  @override
  Future<RemoteAppConfig> fetchConfig() => _client.config.fetch();
}
