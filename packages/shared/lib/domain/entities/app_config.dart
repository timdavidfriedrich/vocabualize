import 'package:dart_mappable/dart_mappable.dart';

part 'app_config.mapper.dart';

const _lowestBuild = 0;

@MappableClass()
class const AppConfig({
  required final int minSupportedBuild,
  required final bool maintenanceMode,
  required final String? maintenanceMessage,
}) with AppConfigMappable;

const defaultAppConfig = AppConfig(
  minSupportedBuild: _lowestBuild,
  maintenanceMode: false,
  maintenanceMessage: null,
);
