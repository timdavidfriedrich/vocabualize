import 'package:shared/data/models/local_backup.dart';

abstract class BackupArchiveDataSource {
  Future<LocalBackupArchive> readArchive(String archivePath);

  Future<String?> findImageFile(LocalBackupArchive archive, String imagePath);

  String imageEntryPath(String localImagePath);

  Future<String> writeArchive({
    required LocalBackupContents contents,
    required Map<String, String> images,
    required List<String> missingImages,
    required LocalBackupLanguages? languages,
  });

  Future<void> deleteArchive(LocalBackupArchive archive);
}
