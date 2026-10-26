import 'package:serverpod/serverpod.dart';

import '../domain/install_registry.dart';
import '../generated/protocol.dart';

class InstallEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<RemoteInstallKey> register(Session session) => const InstallRegistry().register(session);

  Future<void> delete(
    Session session,
    RemoteInstallKey installKey,
  ) => const InstallRegistry().delete(session, installKey);
}
