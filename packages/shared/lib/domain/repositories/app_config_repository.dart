import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/app_config.dart';

abstract class AppConfigRepository {
  Stream<AppResult<AppConfig>> watchConfig();

  Future<AppResult<()>> refresh();
}
