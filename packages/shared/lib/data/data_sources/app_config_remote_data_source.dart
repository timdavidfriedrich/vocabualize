import 'package:vocabualize_client/vocabualize_client.dart';

abstract class AppConfigRemoteDataSource {
  Future<RemoteAppConfig> fetchConfig();
}
