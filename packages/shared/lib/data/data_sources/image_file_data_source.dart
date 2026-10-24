import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/models/local_image_variant.dart';

const _imageExtension = ".webp";
const _thumbnailSuffix = "_thumbnail";
const _partialSuffix = ".part";

abstract class ImageFileDataSource {
  Stream<void> watchChanges();

  Future<Map<String, ({String? full, String? thumbnail})>> findImagePaths(
    Iterable<String> imageIds,
  );

  Future<Set<String>> findMissingImageIds(Iterable<String> imageIds, LocalImageVariant variant);

  Future<Uint8List?> readImage(String imageId, LocalImageVariant variant);

  Future<String> writeImage(String imageId, LocalImageVariant variant, Uint8List bytes);

  Future<void> deleteImage(String imageId);
}

@LazySingleton(as: ImageFileDataSource)
class ImageFileDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements ImageFileDataSource {
  final _changes = StreamController<void>.broadcast();

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
    final directoryPath = _requireDirectoryPath();
    final entries = await Future.wait(
      uniqueIds.map(
        (imageId) async => MapEntry(imageId, (
          full: await _existingPath(directoryPath, imageId, LocalImageVariant.full),
          thumbnail: await _existingPath(directoryPath, imageId, LocalImageVariant.thumbnail),
        )),
      ),
    );
    return Map.fromEntries(entries);
  }

  @override
  Future<Set<String>> findMissingImageIds(
    Iterable<String> imageIds,
    LocalImageVariant variant,
  ) async {
    final uniqueIds = imageIds.toSet();
    if (uniqueIds.isEmpty) return const {};
    final directory = Directory(_requireDirectoryPath());
    final fileNames = {
      await for (final entity in directory.list())
        if (entity is File) entity.uri.pathSegments.last,
    };
    return {
      for (final imageId in uniqueIds)
        if (!fileNames.contains(_fileName(imageId, variant))) imageId,
    };
  }

  @override
  Future<Uint8List?> readImage(String imageId, LocalImageVariant variant) async {
    final file = File(_path(_requireDirectoryPath(), imageId, variant));
    if (!await file.exists()) return null;
    return file.readAsBytes();
  }

  @override
  Future<String> writeImage(String imageId, LocalImageVariant variant, Uint8List bytes) async {
    final path = _path(_requireDirectoryPath(), imageId, variant);
    final partialFile = File("$path$_partialSuffix");
    await partialFile.writeAsBytes(bytes, flush: true);
    await partialFile.rename(path);
    _changes.add(null);
    return path;
  }

  @override
  Future<void> deleteImage(String imageId) async {
    final directoryPath = _requireDirectoryPath();
    for (final variant in LocalImageVariant.values) {
      final file = File(_path(directoryPath, imageId, variant));
      if (await file.exists()) await file.delete();
    }
    _changes.add(null);
  }

  Future<String?> _existingPath(
    String directoryPath,
    String imageId,
    LocalImageVariant variant,
  ) async {
    final path = _path(directoryPath, imageId, variant);
    return await File(path).exists() ? path : null;
  }

  String _requireDirectoryPath() {
    final directoryPath = _sessions.currentImageDirectoryPath;
    if (directoryPath == null) throw StateError("No database is open.");
    return directoryPath;
  }

  String _path(String directoryPath, String imageId, LocalImageVariant variant) =>
      "$directoryPath/${_fileName(imageId, variant)}";

  String _fileName(String imageId, LocalImageVariant variant) => switch (variant) {
    LocalImageVariant.full => "$imageId$_imageExtension",
    LocalImageVariant.thumbnail => "$imageId$_thumbnailSuffix$_imageExtension",
  };
}
