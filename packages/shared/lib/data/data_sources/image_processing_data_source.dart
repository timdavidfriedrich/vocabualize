import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';

const _fullLongEdge = 1280;
const _thumbnailLongEdge = 256;
const _storageQuality = 80;
const _labelingQuality = 70;

abstract class ImageProcessingDataSource {
  Future<({Uint8List full, Uint8List thumbnail})> processImage(String sourcePath);

  Future<({Uint8List full, Uint8List thumbnail})> processSquareImage(String sourcePath);

  Future<({Uint8List full, Uint8List thumbnail})> processBytes(Uint8List bytes);

  Future<Uint8List> createLabelingImage(Uint8List fullBytes, {required int longEdge});

  Future<void> deleteSourceImage(String sourcePath);
}

@Injectable(as: ImageProcessingDataSource)
class const ImageProcessingDataSourceImpl() implements ImageProcessingDataSource {
  @override
  Future<({Uint8List full, Uint8List thumbnail})> processImage(String sourcePath) async {
    final targetEdge = await _squareTargetEdge(
      await ui.ImmutableBuffer.fromFilePath(sourcePath),
      _fullLongEdge,
    );
    final full = await FlutterImageCompress.compressWithFile(
      sourcePath,
      minWidth: targetEdge,
      minHeight: targetEdge,
      quality: _storageQuality,
      format: CompressFormat.webp,
    );
    if (full == null) throw StateError("The image could not be compressed.");
    final thumbnail = await _compressBytes(
      full,
      _thumbnailLongEdge,
      _storageQuality,
      CompressFormat.webp,
    );
    return (full: full, thumbnail: thumbnail);
  }

  @override
  Future<({Uint8List full, Uint8List thumbnail})> processSquareImage(String sourcePath) async {
    final codec = await ui.instantiateImageCodecFromBuffer(
      await ui.ImmutableBuffer.fromFilePath(sourcePath),
    );
    final image = (await codec.getNextFrame()).image;
    codec.dispose();
    final side = min(image.width, image.height).toDouble();
    final source = ui.Rect.fromLTWH(
      (image.width - side) / 2,
      (image.height - side) / 2,
      side,
      side,
    );
    final scale = min(1.0, _fullLongEdge / max(source.width, source.height));
    final width = max(1, (source.width * scale).round());
    final height = max(1, (source.height * scale).round());
    final recorder = ui.PictureRecorder();
    ui.Canvas(recorder).drawImageRect(
      image,
      source,
      ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      ui.Paint()..filterQuality = ui.FilterQuality.high,
    );
    final picture = recorder.endRecording();
    final cropped = await picture.toImage(width, height);
    picture.dispose();
    image.dispose();
    final bytes = await cropped.toByteData(format: ui.ImageByteFormat.png);
    cropped.dispose();
    if (bytes == null) throw StateError("The image could not be cropped.");
    return processBytes(bytes.buffer.asUint8List());
  }

  @override
  Future<({Uint8List full, Uint8List thumbnail})> processBytes(Uint8List bytes) async {
    final full = await _compressBytes(bytes, _fullLongEdge, _storageQuality, CompressFormat.webp);
    final thumbnail = await _compressBytes(
      full,
      _thumbnailLongEdge,
      _storageQuality,
      CompressFormat.webp,
    );
    return (full: full, thumbnail: thumbnail);
  }

  @override
  Future<Uint8List> createLabelingImage(Uint8List fullBytes, {required int longEdge}) {
    return _compressBytes(fullBytes, longEdge, _labelingQuality, CompressFormat.jpeg);
  }

  @override
  Future<void> deleteSourceImage(String sourcePath) async {
    final file = File(sourcePath);
    if (await file.exists()) await file.delete();
  }

  Future<Uint8List> _compressBytes(
    Uint8List bytes,
    int longEdge,
    int quality,
    CompressFormat format,
  ) async {
    final targetEdge = await _squareTargetEdge(
      await ui.ImmutableBuffer.fromUint8List(bytes),
      longEdge,
    );
    return FlutterImageCompress.compressWithList(
      bytes,
      minWidth: targetEdge,
      minHeight: targetEdge,
      quality: quality,
      format: format,
    );
  }

  // * The plugin scales by min(width / minWidth, height / minHeight), so a square target
  // * of longEdge * shortSide / longSide caps the long side at longEdge in any orientation.
  Future<int> _squareTargetEdge(ui.ImmutableBuffer buffer, int longEdge) async {
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final shortSide = min(descriptor.width, descriptor.height);
    final longSide = max(descriptor.width, descriptor.height);
    descriptor.dispose();
    buffer.dispose();
    return longEdge * shortSide ~/ longSide;
  }
}
