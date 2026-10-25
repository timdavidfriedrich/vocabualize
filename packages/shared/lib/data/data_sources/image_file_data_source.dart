import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/space_storage_data_source.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/data/models/storage_space.dart';

const _imageExtension = ".webp";
const _thumbnailSuffix = "_thumbnail";
const _partialSuffix = ".part";

typedef _ImageIndex = ({String directoryPath, Set<String> fileNames});

abstract class ImageFileDataSource {
  Stream<void> watchChanges();

  Future<Map<String, ({String? full, String? thumbnail})>> findImagePaths(
    Iterable<String> imageIds,
  );

  Future<Set<String>> findMissingImageIds(Iterable<String> imageIds, LocalImageVariant variant);

  Future<Uint8List?> readImage(String imageId, LocalImageVariant variant);

  Future<String> writeImage(String imageId, LocalImageVariant variant, Uint8List bytes);

  Future<void> deleteImage(String imageId);

  Future<void> moveImages({required StorageSpace from, required StorageSpace to});
}

@LazySingleton(as: ImageFileDataSource)
class ImageFileDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
  final SpaceStorageDataSource _storage,
) implements ImageFileDataSource {
  final _changes = StreamController<void>.broadcast();
  ({OfflineSyncDatabaseSession session, Future<_ImageIndex> index})? _loadedIndex;

  @override
  Stream<void> watchChanges() async* {
    yield null;
    yield* _changes.stream;
  }

  @override
  Future<Map<String, ({String? full, String? thumbnail})>> findImagePaths(
    Iterable<String> imageIds,
  ) async {
    final uniqueIds = imageIds.toSet();
    if (uniqueIds.isEmpty) return const {};
    final index = await _currentIndex();
    return {
      for (final imageId in uniqueIds)
        imageId: (
          full: _existingPath(index, imageId, LocalImageVariant.full),
          thumbnail: _existingPath(index, imageId, LocalImageVariant.thumbnail),
        ),
    };
  }

  @override
  Future<Set<String>> findMissingImageIds(
    Iterable<String> imageIds,
    LocalImageVariant variant,
  ) async {
    final uniqueIds = imageIds.toSet();
    if (uniqueIds.isEmpty) return const {};
    final index = await _currentIndex();
    return {
      for (final imageId in uniqueIds)
        if (_existingPath(index, imageId, variant) == null) imageId,
    };
  }

  @override
  Future<Uint8List?> readImage(String imageId, LocalImageVariant variant) async {
    final path = _existingPath(await _currentIndex(), imageId, variant);
    if (path == null) return null;
    return File(path).readAsBytes();
  }

  @override
  Future<String> writeImage(String imageId, LocalImageVariant variant, Uint8List bytes) async {
    final index = await _currentIndex();
    final fileName = _fileName(imageId, variant);
    final path = "${index.directoryPath}/$fileName";
    final partialFile = File("$path$_partialSuffix");
    await partialFile.writeAsBytes(bytes, flush: true);
    await partialFile.rename(path);
    index.fileNames.add(fileName);
    _changes.add(null);
    return path;
  }

  @override
  Future<void> deleteImage(String imageId) async {
    final index = await _currentIndex();
    for (final variant in LocalImageVariant.values) {
      final fileName = _fileName(imageId, variant);
      final file = File("${index.directoryPath}/$fileName");
      if (await file.exists()) await file.delete();
      index.fileNames.remove(fileName);
    }
    _changes.add(null);
  }

  @override
  Future<void> moveImages({required StorageSpace from, required StorageSpace to}) async {
    final source = await _storage.imagesDirectory(from);
    if (!await source.exists()) return;
    final target = await _storage.imagesDirectory(to);
    await target.create(recursive: true);
    await for (final entity in source.list()) {
      if (entity is File) await entity.rename("${target.path}/${_name(entity)}");
    }
    _loadedIndex = null;
    _changes.add(null);
  }

  Future<_ImageIndex> _currentIndex() {
    final session = _sessions.currentSession;
    final space = _sessions.currentSpace;
    if (session == null || space == null) return Future.error(StateError("No database is open."));
    if (_loadedIndex case (session: final indexed, :final index) when identical(indexed, session)) {
      return index;
    }
    final index = _loadIndex(session, space);
    _loadedIndex = (session: session, index: index);
    return index;
  }

  Future<_ImageIndex> _loadIndex(OfflineSyncDatabaseSession session, StorageSpace space) async {
    try {
      final directory = await _storage.imagesDirectory(space);
      final fileNames = <String>{
        if (await directory.exists())
          await for (final entity in directory.list())
            if (entity is File) _name(entity),
      };
      return (directoryPath: directory.path, fileNames: fileNames);
    } on Object {
      if (identical(_loadedIndex?.session, session)) _loadedIndex = null;
      rethrow;
    }
  }

  String? _existingPath(_ImageIndex index, String imageId, LocalImageVariant variant) {
    final fileName = _fileName(imageId, variant);
    return index.fileNames.contains(fileName) ? "${index.directoryPath}/$fileName" : null;
  }

  String _name(File file) => file.path.split(Platform.pathSeparator).last;

  String _fileName(String imageId, LocalImageVariant variant) => switch (variant) {
    LocalImageVariant.full => "$imageId$_imageExtension",
    LocalImageVariant.thumbnail => "$imageId$_thumbnailSuffix$_imageExtension",
  };
}
