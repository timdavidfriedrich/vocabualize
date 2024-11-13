import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

extension VocabularyImageExtensions on VocabularyImage {
  // TODO: Make it easiert and safer to get size variants of images (VocabularyImageExtentions) => maybe with class/enum, and pass it here
  ImageProvider getImageProvider() {
    return getImage().image;
  }

  Image getImage() {
    switch (runtimeType) {
      case const (StockImage):
        return Image.network(url);
      case const (CustomImage):
        return Image.network(url);
      case const (FallbackImage):
        return Image.network(url);
      case const (DraftImage):
        return Image.memory((this as DraftImage).content);
      default:
        return Image.network(url);
    }
  }
}
