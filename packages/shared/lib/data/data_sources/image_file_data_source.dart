import 'dart:async';
import 'dart:typed_data';

import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/data/models/storage_space.dart';

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
