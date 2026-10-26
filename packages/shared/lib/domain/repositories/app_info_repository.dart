import 'package:core/error/app_result.dart';

abstract class AppInfoRepository {
  Future<AppResult<int>> getBuildNumber();

  Future<AppResult<()>> openStoreListing();

  Future<AppResult<()>> openDateSettings();

  Future<AppResult<()>> openAppSettings();

  Future<AppResult<()>> openInternetSettings();
}
