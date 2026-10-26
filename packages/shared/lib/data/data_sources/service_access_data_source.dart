import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _installKeyStorageKey = "vocabualize.installKey";
const _invalidKeyReason = "invalidKey";

abstract class ServiceAccessDataSource {
  Future<T> run<T>(Future<T> Function(RemoteInstallKey? installKey) request);

  Future<void> forgetInstall();
}

@LazySingleton(as: ServiceAccessDataSource)
class ServiceAccessDataSourceImpl(
  final Client _client,
  final FlutterAuthSessionManager _sessionManager,
  final FlutterSecureStorage _secureStorage,
) implements ServiceAccessDataSource {
  RemoteInstallKey? _installKey;
  Future<RemoteInstallKey>? _loadingInstallKey;

  @override
  Future<T> run<T>(Future<T> Function(RemoteInstallKey? installKey) request) async {
    if (_sessionManager.authInfo != null) return request(null);
    try {
      return await request(await _currentInstallKey());
    } on InstallRejectedException catch (exception) {
      if (exception.reason != _invalidKeyReason) rethrow;
      await _removeInstallKey();
      return request(await _currentInstallKey());
    }
  }

  @override
  Future<void> forgetInstall() async {
    final installKey = _installKey ?? await _readInstallKey();
    await _removeInstallKey();
    if (installKey != null) unawaited(_deleteRemoteInstall(installKey));
  }

  Future<RemoteInstallKey> _currentInstallKey() async {
    return _installKey ??
        await (_loadingInstallKey ??= _loadOrRegister().whenComplete(
          () => _loadingInstallKey = null,
        ));
  }

  Future<RemoteInstallKey> _loadOrRegister() async {
    final installKey = await _readInstallKey() ?? await _register();
    _installKey = installKey;
    return installKey;
  }

  Future<RemoteInstallKey> _register() async {
    final installKey = await _client.install.register();
    await _secureStorage.write(key: _installKeyStorageKey, value: jsonEncode(installKey.toJson()));
    return installKey;
  }

  Future<RemoteInstallKey?> _readInstallKey() async {
    final stored = await _secureStorage.read(key: _installKeyStorageKey);
    if (stored == null) return null;
    try {
      return RemoteInstallKey.fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  Future<void> _removeInstallKey() async {
    _installKey = null;
    await _secureStorage.delete(key: _installKeyStorageKey);
  }

  Future<void> _deleteRemoteInstall(RemoteInstallKey installKey) async {
    try {
      await _client.install.delete(installKey);
    } on Object {
      return;
    }
  }
}
