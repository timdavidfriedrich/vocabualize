import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/backup_import_status.dart';

abstract class BackupRepository {
  Future<AppResult<()>> exportBackup();

  Stream<AppResult<BackupImportStatus>> importBackup();
}
