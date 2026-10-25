import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/processed_image.dart';

part 'vocabulary_image_change.mapper.dart';

@MappableClass()
sealed class VocabularyImageChange with VocabularyImageChangeMappable {
  const VocabularyImageChange();
}

@MappableClass()
class const KeepImage() extends VocabularyImageChange with KeepImageMappable;

@MappableClass()
class const RemoveImage() extends VocabularyImageChange with RemoveImageMappable;

@MappableClass()
class const ReplaceImage({
  required final ProcessedImage image,
}) extends VocabularyImageChange with ReplaceImageMappable;
