import 'package:core/error/app_result.dart';

abstract class AppInfoRepository {
  Future<AppResult<int>> getBuildNumber();

  Future<AppResult<()>> openStoreListing();
}
