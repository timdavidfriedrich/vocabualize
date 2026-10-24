import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/app_config.dart';
import 'package:shared/domain/entities/gate_status.dart';
import 'package:shared/domain/repositories/app_config_repository.dart';
import 'package:shared/domain/repositories/app_info_repository.dart';

@injectable
class const WatchGateStatusUseCase(
  final AppConfigRepository _appConfigRepository,
  final AppInfoRepository _appInfoRepository,
) {
  Stream<AppResult<GateStatus>> call() async* {
    switch (await _appInfoRepository.getBuildNumber()) {
      case Failure(:final error):
        yield Failure(error);
      case Success(data: final buildNumber):
        yield* _appConfigRepository.watchConfig().map(
          (result) => switch (result) {
            Success(data: final config) => Success(_toGateStatus(config, buildNumber)),
            Failure(:final error) => Failure(error),
          },
        );
    }
  }

  GateStatus _toGateStatus(AppConfig config, int buildNumber) => switch (config) {
    AppConfig(maintenanceMode: true, :final maintenanceMessage) => GateMaintenance(
      message: maintenanceMessage,
    ),
    AppConfig(:final minSupportedBuild) when buildNumber < minSupportedBuild =>
      const GateUpdateRequired(),
    AppConfig() => const GateOpen(),
  };
}
