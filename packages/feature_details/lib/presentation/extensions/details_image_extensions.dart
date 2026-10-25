import 'dart:io';

import 'package:feature_details/presentation/details_state.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

extension DetailsImageExtensions on DetailsImage {
  ImageProvider? toImageProvider({required bool isThumbnail}) {
    return switch (this) {
      DetailsNoImage() || DetailsSavedImage(image: NoImage()) => null,
      DetailsNewPhoto(:final image) => MemoryImage(
        isThumbnail ? image.thumbnailBytes : image.fullBytes,
      ),
      DetailsSavedImage(image: CustomImage(:final fullPath, :final thumbnailPath)) =>
        switch (isThumbnail ? (thumbnailPath ?? fullPath) : (fullPath ?? thumbnailPath)) {
          final path? => FileImage(File(path)),
          null => null,
        },
      DetailsStockPhoto(image: StockImage(:final url, :final thumbUrl)) ||
      DetailsSavedImage(image: StockImage(:final url, :final thumbUrl)) => NetworkImage(
        isThumbnail ? thumbUrl : url,
      ),
    };
  }
}
