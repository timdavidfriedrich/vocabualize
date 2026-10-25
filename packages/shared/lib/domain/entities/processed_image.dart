import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';

part 'processed_image.mapper.dart';

@MappableClass()
class const ProcessedImage({
  required final Uint8List fullBytes,
  required final Uint8List thumbnailBytes,
  required final String? photographer,
  required final String? photographerUrl,
}) with ProcessedImageMappable;
