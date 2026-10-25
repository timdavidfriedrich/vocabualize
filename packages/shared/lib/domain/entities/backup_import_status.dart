import 'package:dart_mappable/dart_mappable.dart';

part 'backup_import_status.mapper.dart';

@MappableClass()
sealed class BackupImportStatus with BackupImportStatusMappable {
  const BackupImportStatus();
}

@MappableClass()
class const BackupImportCancelled() extends BackupImportStatus with BackupImportCancelledMappable;

@MappableClass()
class const BackupImportRunning({
  required final int processedImages,
  required final int totalImages,
}) extends BackupImportStatus with BackupImportRunningMappable;

@MappableClass()
class const BackupImportCompleted({
  required final int importedCount,
}) extends BackupImportStatus with BackupImportCompletedMappable;
