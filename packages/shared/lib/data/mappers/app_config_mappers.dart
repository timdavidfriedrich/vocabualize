import 'package:shared/domain/entities/app_config.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

extension RemoteAppConfigMappers on RemoteAppConfig {
  AppConfig toAppConfig() {
    return AppConfig(
      minSupportedBuild: minSupportedBuild,
      maintenanceMode: maintenanceMode,
      maintenanceMessage: maintenanceMessage,
    );
  }
}
