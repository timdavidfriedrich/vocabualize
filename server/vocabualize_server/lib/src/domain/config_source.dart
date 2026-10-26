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
  final ai = _mapAt(root["ai"], "ai");
  final reports = _mapAt(root["reports"], "reports");
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
    ai: AiConfig(
      enabled: _boolAt(ai["enabled"], "ai.enabled"),
      translationProvider: _stringAt(ai["translationProvider"], "ai.translationProvider"),
      stockImageProvider: _stringAt(ai["stockImageProvider"], "ai.stockImageProvider"),
      imageLabelingProvider: _stringAt(ai["imageLabelingProvider"], "ai.imageLabelingProvider"),
      imageLabelingModel: _stringAt(ai["imageLabelingModel"], "ai.imageLabelingModel"),
      translationsPerDay: _intAt(ai["translationsPerDay"], "ai.translationsPerDay"),
      stockSearchesPerDay: _intAt(ai["stockSearchesPerDay"], "ai.stockSearchesPerDay"),
      imageLabelingsPerDay: _intAt(ai["imageLabelingsPerDay"], "ai.imageLabelingsPerDay"),
      maxTextLength: _intAt(ai["maxTextLength"], "ai.maxTextLength"),
      maxLabelingImageBytes: _intAt(ai["maxLabelingImageBytes"], "ai.maxLabelingImageBytes"),
      englishTarget: _stringAt(ai["englishTarget"], "ai.englishTarget"),
    ),
    reports: ReportsConfig(
      enabled: _boolAt(reports["enabled"], "reports.enabled"),
      perIpPerHour: _intAt(reports["perIpPerHour"], "reports.perIpPerHour"),
      perIpPerDay: _intAt(reports["perIpPerDay"], "reports.perIpPerDay"),
      perDay: _intAt(reports["perDay"], "reports.perDay"),
      maxMessageLength: _intAt(reports["maxMessageLength"], "reports.maxMessageLength"),
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
