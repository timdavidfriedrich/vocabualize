import 'dart:io';

import 'package:yaml/yaml.dart';

import '../generated/protocol.dart';

const _configPath = "app_config.yaml";

class const ConfigSource() {
  static RuntimeConfig? _cached;
  static DateTime? _cachedModifiedAt;

  RuntimeConfig read() {
    final file = File(_configPath);
    if (!file.existsSync()) {
      throw StateError(
        "Runtime configuration is missing. Expected `$_configPath` relative to "
        "${Directory.current.path}.",
      );
    }
    final modifiedAt = file.lastModifiedSync();
    final cached = _cached;
    if (cached != null && _cachedModifiedAt == modifiedAt) return cached;
    final parsed = _parse(file.readAsStringSync());
    _cached = parsed;
    _cachedModifiedAt = modifiedAt;
    return parsed;
  }
}

RuntimeConfig _parse(String source) {
  final root = _mapAt(loadYaml(source), "root");
  final version = _intAt(root["version"], "version");
  final client = _mapAt(root["client"], "client");
  final images = _mapAt(root["images"], "images");
  return RuntimeConfig(
    version: version,
    client: RemoteAppConfig(
      version: version,
      minSupportedBuild: _intAt(client["minSupportedBuild"], "client.minSupportedBuild"),
      maintenanceMode: _boolAt(client["maintenanceMode"], "client.maintenanceMode"),
      maintenanceMessage: _optionalStringAt(
        client["maintenanceMessage"],
        "client.maintenanceMessage",
      ),
    ),
    images: ImageStorageConfig(
      provider: _stringAt(images["provider"], "images.provider"),
      bucket: _stringAt(images["bucket"], "images.bucket"),
      region: _stringAt(images["region"], "images.region"),
      endpoint: _stringAt(images["endpoint"], "images.endpoint"),
      publicEndpoint: _stringAt(images["publicEndpoint"], "images.publicEndpoint"),
    ),
  );
}

Map<dynamic, dynamic> _mapAt(Object? value, String path) =>
    value is Map ? value : _invalid(path, "a map");

int _intAt(Object? value, String path) => value is int ? value : _invalid(path, "an integer");

bool _boolAt(Object? value, String path) => value is bool ? value : _invalid(path, "true or false");

String _stringAt(Object? value, String path) =>
    value is String ? value : _invalid(path, "a string");

String? _optionalStringAt(Object? value, String path) =>
    value == null ? null : _stringAt(value, path);

Never _invalid(String path, String expected) =>
    throw StateError("`$_configPath` is invalid: `$path` must be $expected.");
