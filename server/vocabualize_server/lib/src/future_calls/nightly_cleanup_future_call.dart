import 'package:serverpod/serverpod.dart';

import '../domain/nightly_cleanup.dart';

class NightlyCleanupFutureCall extends FutureCall {
  Future<void> run(Session session) => const NightlyCleanup().run(session);
}
