import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/widgets/vocabulary_fallback_image.dart';

enum VocabularyImageVariant { thumbnail, full }

class const VocabularyImageView({
  super.key,
  required final VocabularyImage _image,
  required final VocabularyImageVariant _variant,
  required final double _displayWidth,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = _provider;
    if (provider == null) return VocabularyFallbackImage(displayWidth: _displayWidth);
    return Image(
      image: ResizeImage(
        provider,
        width: (_displayWidth * MediaQuery.devicePixelRatioOf(context)).round(),
      ),
      fit: BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) =>
          VocabularyFallbackImage(displayWidth: _displayWidth),
    );
  }

  ImageProvider? get _provider => switch ((_image, _variant)) {
    (CustomImage(fullPath: final path?), VocabularyImageVariant.full) ||
    (CustomImage(thumbnailPath: final path?), _) ||
    (CustomImage(fullPath: final path?), _) => FileImage(File(path)),
    (StockImage(:final url), VocabularyImageVariant.full) => NetworkImage(url),
    (StockImage(:final thumbUrl), VocabularyImageVariant.thumbnail) => NetworkImage(thumbUrl),
    (CustomImage() || NoImage(), _) => null,
  };
}
