import 'dart:typed_data';

import 'package:vocabualize/constants/image_constants.dart';

enum ImageSize { tiny, small, medium, large, original }

sealed class VocabularyImage {
  const VocabularyImage();
}

class StockImage extends VocabularyImage {
  final String id;
  final String url;
  final int width;
  final int height;
  final String? photographer;
  final String? photographerUrl;
  final Map<ImageSize, String>? sizeVariants;

  const StockImage({
    required this.url,
    this.id = "",
    this.width = ImageConstants.fallbackImageWidth,
    this.height = ImageConstants.fallbackImageHeight,
    this.photographer = "Unknown",
    this.photographerUrl,
    this.sizeVariants,
  });
}

class CustomImage extends VocabularyImage {
  final String url;
  const CustomImage({
    required this.url,
  });
}

class FallbackImage extends VocabularyImage {
  const FallbackImage();
}

class DraftImage extends VocabularyImage {
  final Uint8List content;

  const DraftImage({
    required this.content,
  });
}
