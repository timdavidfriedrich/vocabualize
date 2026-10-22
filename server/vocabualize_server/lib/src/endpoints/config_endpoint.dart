import 'package:serverpod/serverpod.dart';

import '../domain/config_source.dart';
import '../generated/protocol.dart';

const _config = ConfigSource();

class ConfigEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<RemoteAppConfig> fetch(Session session) async => _config.read().client;
}
