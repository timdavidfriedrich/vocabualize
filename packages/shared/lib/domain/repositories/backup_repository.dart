import 'package:core/error/app_result.dart';

abstract class BackupRepository {
  Future<AppResult<()>> exportBackup();

  Future<AppResult<int?>> importBackup();
}
