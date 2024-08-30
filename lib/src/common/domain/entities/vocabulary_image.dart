import 'dart:typed_data';

import 'package:vocabualize/constants/image_constants.dart';

sealed class VocabularyImage {
  final String id;
  final String url;

  const VocabularyImage({
    required this.id,
    required this.url,
  });
}

class StockImage extends VocabularyImage {
  final int width;
  final int height;
  final String? photographer;
  final String? photographerUrl;
  final Map<String, dynamic>? sizeVariants;

  const StockImage({
    required super.id,
    this.width = ImageConstants.fallbackImageWidth,
    this.height = ImageConstants.fallbackImageHeight,
    required super.url,
    required this.photographer,
    this.photographerUrl,
    this.sizeVariants,
  });
}

class CustomImage extends VocabularyImage {
  const CustomImage({
    required super.id,
    required super.url,
  });
}

// TODO: Change this to a local image from assets
class FallbackImage extends VocabularyImage {
  const FallbackImage()
      : super(
          id: "fallback",
          url: ImageConstants.fallbackImageUrl,
        );
}

class DraftImage extends VocabularyImage {
  final Uint8List content;

  const DraftImage({
    required this.content,
  }) : super(
          id: "draft",
          url: "",
        );
}
