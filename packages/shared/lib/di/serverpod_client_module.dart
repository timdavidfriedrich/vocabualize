import 'package:core/config/build_config.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _fallbackBaseUrl = "http://localhost:8180/";

@module
abstract class ServerpodClientModule {
  @lazySingleton
  FlutterAuthSessionManager sessionManager() => FlutterAuthSessionManager();

  @lazySingleton
  ConnectivityMonitor connectivityMonitor() => FlutterConnectivityMonitor();

  @lazySingleton
  Client client(FlutterAuthSessionManager sessionManager, ConnectivityMonitor connectivityMonitor) {
    final client = Client(apiBaseUrl.isEmpty ? _fallbackBaseUrl : apiBaseUrl)
      ..connectivityMonitor = connectivityMonitor;
    sessionManager.setCaller(client.modules.serverpod_auth_core);
    client.authKeyProvider = sessionManager;
    return client;
  }
}
