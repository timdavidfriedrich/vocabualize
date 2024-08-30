import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

extension VocabularyImageExtentions on VocabularyImage {
  ImageProvider getImageProvider() {
    return getImage().image;
  }

  Image getImage() {
    switch (runtimeType) {
      case StockImage _:
        return Image.network(url);
      case CustomImage _:
        return Image.network(url);
      case FallbackImage _:
        return Image.network(url);
      case DraftImage _:
        return Image.memory((this as DraftImage).content);
      default:
        return Image.network(url);
    }
  }
}
