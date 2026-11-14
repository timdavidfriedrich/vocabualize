import 'dart:typed_data';

import 'package:vocabualize_client/vocabualize_client.dart';

abstract class ImageLabelingRemoteDataSource {
  Future<List<RemoteImageLabel>> label({
    required Uint8List image,
    required String language,
  });
}
