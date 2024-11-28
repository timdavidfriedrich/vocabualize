import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

extension VocabularyImageExtensions on VocabularyImage {
  ImageProvider getImageProvider({ImageSize size = ImageSize.original}) {
    return switch (runtimeType) {
      const (FallbackImage) => Image.asset(AssetPath.fallbackDefault).image,
      const (DraftImage) => Image.memory((this as DraftImage).content).image,
      const (StockImage) => CachedNetworkImageProvider(
          (this as StockImage).sizeVariants?[size] ?? (this as StockImage).url,
        ),
      const (CustomImage) => CachedNetworkImageProvider(
          (this as CustomImage).url,
        ),
      _ => throw UnimplementedError(
          "Unknown VocabularyImage type: \"$runtimeType\"",
        ),
    };
  }

  Image getImage({ImageSize size = ImageSize.original}) {
    return Image(image: getImageProvider(size: size));
  }
}
