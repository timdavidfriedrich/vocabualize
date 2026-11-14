import 'dart:async';

import 'package:vocabualize_client/vocabualize_client.dart';

abstract class ServiceAccessDataSource {
  Future<T> run<T>(Future<T> Function(RemoteInstallKey? installKey) request);

  Future<void> forgetInstall();
}
