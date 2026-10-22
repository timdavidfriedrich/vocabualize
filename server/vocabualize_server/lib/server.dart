import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';

import 'src/composition.dart';
import 'src/domain/config_source.dart';
import 'src/generated/serverpod.dart';

List<IdentityProviderBuilder> _identityProviders(Serverpod pod) {
  final hasGoogle = pod.getPassword("googleClientSecret") != null;
  if (pod.runMode == ServerpodRunMode.production && !hasGoogle) {
    throw StateError("Production needs googleClientSecret in config/passwords.yaml.");
  }
  return [
    if (hasGoogle) GoogleIdpConfigFromPasswords(),
  ];
}

void run(List<String> args) async {
  final pod = Serverpod(args);
  const ConfigSource().read();
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: _identityProviders(pod),
  );
  pod.addCloudStorage(const Composition().imageStorage());
  pod.addCloudStorage(DatabaseCloudStorage("public"));
  pod.addCloudStorage(DatabaseCloudStorage("private"));
  await pod.start();
}
