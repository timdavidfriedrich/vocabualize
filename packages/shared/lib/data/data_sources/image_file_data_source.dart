import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';

const _imageExtension = ".webp";
const _thumbnailSuffix = "_thumbnail";

abstract class ImageFileDataSource {
  ({String full, String thumbnail}) imagePaths(String imageId);

  Future<void> writeImage(
    String imageId, {
    required Uint8List full,
    required Uint8List thumbnail,
  });

  Future<void> deleteImage(String imageId);
}

@Injectable(as: ImageFileDataSource)
class const ImageFileDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements ImageFileDataSource {
  @override
  ({String full, String thumbnail}) imagePaths(String imageId) {
    final directoryPath = _sessions.currentImageDirectoryPath;
    if (directoryPath == null) throw StateError("No database is open.");
    return (
      full: "$directoryPath/$imageId$_imageExtension",
      thumbnail: "$directoryPath/$imageId$_thumbnailSuffix$_imageExtension",
    );
  }

  @override
  Future<void> writeImage(
    String imageId, {
    required Uint8List full,
    required Uint8List thumbnail,
  }) async {
    final paths = imagePaths(imageId);
    await File(paths.full).writeAsBytes(full, flush: true);
    await File(paths.thumbnail).writeAsBytes(thumbnail, flush: true);
  }

  @override
  Future<void> deleteImage(String imageId) async {
    final paths = imagePaths(imageId);
    for (final path in [paths.full, paths.thumbnail]) {
      final file = File(path);
      if (await file.exists()) await file.delete();
    }
  }
}
