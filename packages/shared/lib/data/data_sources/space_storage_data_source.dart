import 'dart:io';
import 'dart:typed_data';

import 'package:shared/data/models/local_account_metadata.dart';
import 'package:shared/data/models/local_custom_practice.dart';
import 'package:shared/data/models/storage_space.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class SpaceStorageDataSource {
  Future<String> databasePath(StorageSpace space);

  Future<Directory> imagesDirectory(StorageSpace space);

  Future<void> createSpace(StorageSpace space);

  Future<bool> hasDatabase(StorageSpace space);

  Future<List<LocalAccountMetadata>> findAccounts();

  Future<LocalAccountMetadata?> readAccount(UuidValue userId);

  Future<void> writeAccount(LocalAccountMetadata account);

  Future<String?> findProfilePicture(LocalAccountMetadata account);

  Future<String> writeProfilePicture(UuidValue userId, Uint8List bytes);

  Future<void> deleteProfilePicture(UuidValue userId, String fileName);

  Future<bool> hasCompletedInitialSync(UuidValue userId);

  Future<void> markInitialSyncCompleted(UuidValue userId);

  Future<UuidValue?> readLocalOwnerId();

  Future<UuidValue> readOrCreateLocalOwnerId();

  Future<LocalCustomPractice?> readCustomPractice(StorageSpace space);

  Future<void> writeCustomPractice(StorageSpace space, LocalCustomPractice practice);

  Future<void> deleteCustomPractice(StorageSpace space);

  Future<void> markForDeletion(StorageSpace space);

  Future<void> deleteMarkedSpaces();
}
