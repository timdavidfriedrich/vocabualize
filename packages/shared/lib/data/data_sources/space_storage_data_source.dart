import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/data/models/local_account_metadata.dart';
import 'package:shared/data/models/storage_space.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _spacesDirectoryName = "spaces";
const _localSpaceName = "local";
const _deletionSuffix = ".deleting";
const _databaseFileName = "database.db";
const _imagesDirectoryName = "images";
const _accountFileName = "account.json";
const _ownerIdFileName = "owner_id";
const _partialSuffix = ".part";

abstract class SpaceStorageDataSource {
  Future<String> databasePath(StorageSpace space);

  Future<Directory> imagesDirectory(StorageSpace space);

  Future<void> createSpace(StorageSpace space);

  Future<bool> hasDatabase(StorageSpace space);

  Future<List<LocalAccountMetadata>> findAccounts();

  Future<LocalAccountMetadata?> readAccount(UuidValue userId);

  Future<void> writeAccount(LocalAccountMetadata account);

  Future<bool> hasCompletedInitialSync(UuidValue userId);

  Future<void> markInitialSyncCompleted(UuidValue userId);

  Future<UuidValue?> readLocalOwnerId();

  Future<UuidValue> readOrCreateLocalOwnerId();

  Future<void> markForDeletion(StorageSpace space);

  Future<void> deleteMarkedSpaces();
}

@Injectable(as: SpaceStorageDataSource)
class const SpaceStorageDataSourceImpl() implements SpaceStorageDataSource {
  @override
  Future<String> databasePath(StorageSpace space) async =>
      "${(await _spaceDirectory(space)).path}/$_databaseFileName";

  @override
  Future<Directory> imagesDirectory(StorageSpace space) async =>
      Directory("${(await _spaceDirectory(space)).path}/$_imagesDirectoryName");

  @override
  Future<void> createSpace(StorageSpace space) async {
    await (await imagesDirectory(space)).create(recursive: true);
  }

  @override
  Future<bool> hasDatabase(StorageSpace space) async => File(await databasePath(space)).exists();

  @override
  Future<List<LocalAccountMetadata>> findAccounts() async {
    final spacesDirectory = await _spacesDirectory();
    if (!await spacesDirectory.exists()) return const [];
    final accounts = <LocalAccountMetadata>[];
    await for (final entity in spacesDirectory.list()) {
      if (entity is! Directory) continue;
      final UuidValue userId;
      try {
        userId = UuidValue.withValidation(entity.path.split(Platform.pathSeparator).last);
      } on FormatException {
        continue;
      }
      accounts.add(await readAccount(userId) ?? _emptyAccount(userId));
    }
    return accounts;
  }

  @override
  Future<LocalAccountMetadata?> readAccount(UuidValue userId) async {
    final file = await _accountFile(userId);
    if (!await file.exists()) return null;
    try {
      return LocalAccountMetadataMapper.fromJson(await file.readAsString());
    } on MapperException {
      return null;
    }
  }

  @override
  Future<void> writeAccount(LocalAccountMetadata account) async {
    final file = await _accountFile(UuidValue.withValidation(account.accountId));
    final partialFile = File("${file.path}$_partialSuffix");
    await partialFile.writeAsString(account.toJson(), flush: true);
    await partialFile.rename(file.path);
  }

  @override
  Future<bool> hasCompletedInitialSync(UuidValue userId) async =>
      (await readAccount(userId))?.hasCompletedInitialSync ?? false;

  @override
  Future<void> markInitialSyncCompleted(UuidValue userId) async {
    final account = await readAccount(userId) ?? _emptyAccount(userId);
    await writeAccount(account.copyWith(hasCompletedInitialSync: true));
  }

  @override
  Future<UuidValue?> readLocalOwnerId() async {
    final file = await _ownerIdFile();
    if (!await file.exists()) return null;
    return UuidValue.withValidation((await file.readAsString()).trim());
  }

  @override
  Future<UuidValue> readOrCreateLocalOwnerId() async {
    if (await readLocalOwnerId() case final ownerId?) return ownerId;
    final ownerId = const Uuid().v7obj();
    await createSpace(const LocalOnlySpace());
    await (await _ownerIdFile()).writeAsString(ownerId.uuid, flush: true);
    return ownerId;
  }

  @override
  Future<void> markForDeletion(StorageSpace space) async {
    final directory = await _spaceDirectory(space);
    if (!await directory.exists()) return;
    final marked = Directory("${directory.path}$_deletionSuffix");
    if (await marked.exists()) await marked.delete(recursive: true);
    await directory.rename(marked.path);
  }

  @override
  Future<void> deleteMarkedSpaces() async {
    final spacesDirectory = await _spacesDirectory();
    if (!await spacesDirectory.exists()) return;
    await for (final entity in spacesDirectory.list()) {
      if (entity is Directory && entity.path.endsWith(_deletionSuffix)) {
        await entity.delete(recursive: true);
      }
    }
  }

  Future<Directory> _spacesDirectory() async =>
      Directory("${(await getApplicationSupportDirectory()).path}/$_spacesDirectoryName");

  Future<Directory> _spaceDirectory(StorageSpace space) async {
    final name = switch (space) {
      LocalOnlySpace() => _localSpaceName,
      AccountSpace(:final userId) => userId.uuid,
    };
    return Directory("${(await _spacesDirectory()).path}/$name");
  }

  Future<File> _accountFile(UuidValue userId) async =>
      File("${(await _spaceDirectory(AccountSpace(userId: userId))).path}/$_accountFileName");

  Future<File> _ownerIdFile() async =>
      File("${(await _spaceDirectory(const LocalOnlySpace())).path}/$_ownerIdFileName");

  LocalAccountMetadata _emptyAccount(UuidValue userId) => LocalAccountMetadata(
    accountId: userId.uuid,
    name: null,
    email: null,
    hasCompletedInitialSync: false,
  );
}
