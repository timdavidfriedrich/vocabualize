import 'dart:async';

import 'package:vocabualize_client/vocabualize_client.dart';

abstract class AppConfigLocalDataSource {
  Stream<RemoteAppConfig?> watchCache();

  Future<void> writeCache(RemoteAppConfig config);
}
