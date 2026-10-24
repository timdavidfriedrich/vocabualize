import 'package:dart_mappable/dart_mappable.dart';

part 'vocabulary_image.mapper.dart';

@MappableClass()
sealed class VocabularyImage with VocabularyImageMappable {
  const VocabularyImage();
}

@MappableClass()
class const NoImage() extends VocabularyImage with NoImageMappable;

@MappableClass()
class const CustomImage({
  required final String imageId,
  required final String? fullPath,
  required final String? thumbnailPath,
}) extends VocabularyImage with CustomImageMappable;

@MappableClass()
class const StockImage({
  required final String id,
  required final String url,
  required final String thumbUrl,
  required final String? photographer,
  required final String? photographerUrl,
}) extends VocabularyImage with StockImageMappable;
