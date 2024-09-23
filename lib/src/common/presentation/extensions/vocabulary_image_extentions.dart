import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

extension VocabularyImageExtentions on VocabularyImage {
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
