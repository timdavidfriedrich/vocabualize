import 'dart:typed_data';

import 'package:shared/data/models/local_image_variant.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class ImageTransferDataSource {
  Future<bool> upload(String imageId, LocalImageVariant variant, Uint8List bytes);

  Future<List<RemoteImageDownload>> createDownloads(
    List<String> imageIds,
    LocalImageVariant variant,
  );

  Future<Uint8List> download(String url);
}
