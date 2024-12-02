// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vocabualize/constants/image_constants.dart';

abstract interface class RdbImage {
  const RdbImage();
}

class RdbStockImage extends RdbImage {
  final String id;
  final int width;
  final int height;
  final String url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerID;
  final String? avgColor;
  final Map<String, dynamic>? src;

  const RdbStockImage({
    this.id = "",
    this.width = ImageConstants.fallbackImageWidth,
    this.height = ImageConstants.fallbackImageHeight,
    this.url = ImageConstants.fallbackImageUrl,
    this.photographer,
    this.photographerUrl,
    this.photographerID,
    this.avgColor,
    this.src,
  });
}

class RdbCustomImage extends RdbImage {
  final String url;

  const RdbCustomImage({
    required this.url,
  });
}
