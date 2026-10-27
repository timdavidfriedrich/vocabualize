import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';

import 'src/composition.dart';
import 'src/domain/config_source.dart';
import 'src/generated/serverpod.dart';

const _nightlyCleanupId = "nightly-cleanup";
// * 03:00 UTC is the middle of the night in Europe, where the app's users are
const _nightlyCleanupSchedule = "0 3 * * *";

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
  await _scheduleNightlyCleanup(pod);
}

Future<void> _scheduleNightlyCleanup(Serverpod pod) async {
  await pod.futureCalls.cancel(_nightlyCleanupId);
  await pod.futureCalls
      .callRecurring(identifier: _nightlyCleanupId)
      .cron(_nightlyCleanupSchedule)
      .nightlyCleanup
      .run();
}
