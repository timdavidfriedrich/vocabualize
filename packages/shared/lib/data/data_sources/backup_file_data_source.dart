abstract class BackupFileDataSource {
  Future<String?> pickArchive();

  Future<void> shareArchive(String archivePath);

  Future<void> clearPickedArchives();
}
