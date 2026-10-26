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
  final tiers = _mapAt(root["tiers"], "tiers");
  final translation = _mapAt(root["translation"], "translation");
  final stockImages = _mapAt(root["stockImages"], "stockImages");
  final imageLabeling = _mapAt(root["imageLabeling"], "imageLabeling");
  final installs = _mapAt(root["installs"], "installs");
  final imageStorage = _mapAt(root["imageStorage"], "imageStorage");
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
    tiers: TiersConfig(
      anonymous: _tierAt(tiers["anonymous"], "tiers.anonymous"),
      free: _tierAt(tiers["free"], "tiers.free"),
      premium: _tierAt(tiers["premium"], "tiers.premium"),
    ),
    translation: TranslationConfig(
      enabled: _boolAt(translation["enabled"], "translation.enabled"),
      provider: _stringAt(translation["provider"], "translation.provider"),
      maxTextLength: _intAt(translation["maxTextLength"], "translation.maxTextLength"),
      englishTarget: _stringAt(translation["englishTarget"], "translation.englishTarget"),
      perDay: _intAt(translation["perDay"], "translation.perDay"),
    ),
    stockImages: StockImagesConfig(
      enabled: _boolAt(stockImages["enabled"], "stockImages.enabled"),
      provider: _stringAt(stockImages["provider"], "stockImages.provider"),
      maxQueryLength: _intAt(stockImages["maxQueryLength"], "stockImages.maxQueryLength"),
      perDay: _intAt(stockImages["perDay"], "stockImages.perDay"),
    ),
    imageLabeling: ImageLabelingConfig(
      enabled: _boolAt(imageLabeling["enabled"], "imageLabeling.enabled"),
      provider: _stringAt(imageLabeling["provider"], "imageLabeling.provider"),
      model: _stringAt(imageLabeling["model"], "imageLabeling.model"),
      maxImageBytes: _intAt(imageLabeling["maxImageBytes"], "imageLabeling.maxImageBytes"),
      perDay: _intAt(imageLabeling["perDay"], "imageLabeling.perDay"),
    ),
    installs: InstallsConfig(
      enabled: _boolAt(installs["enabled"], "installs.enabled"),
      perIpPerDay: _intAt(installs["perIpPerDay"], "installs.perIpPerDay"),
      perDay: _intAt(installs["perDay"], "installs.perDay"),
    ),
    imageStorage: ImageStorageConfig(
      provider: _stringAt(imageStorage["provider"], "imageStorage.provider"),
      bucket: _stringAt(imageStorage["bucket"], "imageStorage.bucket"),
      region: _stringAt(imageStorage["region"], "imageStorage.region"),
      endpoint: _stringAt(imageStorage["endpoint"], "imageStorage.endpoint"),
      publicEndpoint: _stringAt(imageStorage["publicEndpoint"], "imageStorage.publicEndpoint"),
      maxPhotosPerAccount: _intAt(
        imageStorage["maxPhotosPerAccount"],
        "imageStorage.maxPhotosPerAccount",
      ),
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

TierConfig _tierAt(Object? value, String path) {
  final tier = _mapAt(value, path);
  return TierConfig(
    translationsPerDay: _intAt(tier["translationsPerDay"], "$path.translationsPerDay"),
    stockImageSearchesPerDay: _intAt(
      tier["stockImageSearchesPerDay"],
      "$path.stockImageSearchesPerDay",
    ),
    imageLabelingsPerDay: _intAt(tier["imageLabelingsPerDay"], "$path.imageLabelingsPerDay"),
    imageLabelingsPerMonth: _intAt(
      tier["imageLabelingsPerMonth"],
      "$path.imageLabelingsPerMonth",
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
