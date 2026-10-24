import 'package:injectable/injectable.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class AppConfigRemoteDataSource {
  Future<RemoteAppConfig> fetchConfig();
}

@Injectable(as: AppConfigRemoteDataSource)
class const AppConfigRemoteDataSourceImpl(
  final Client _client,
) implements AppConfigRemoteDataSource {
  @override
  Future<RemoteAppConfig> fetchConfig() => _client.config.fetch();
}
