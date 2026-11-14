import 'dart:typed_data';

abstract class ImageProcessingDataSource {
  Future<({Uint8List full, Uint8List thumbnail})> processImage(String sourcePath);

  Future<({Uint8List full, Uint8List thumbnail})> processSquareImage(String sourcePath);

  Future<({Uint8List full, Uint8List thumbnail})> processBytes(Uint8List bytes);

  Future<Uint8List> createLabelingImage(Uint8List fullBytes, {required int longEdge});

  Future<void> deleteSourceImage(String sourcePath);
}
