import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'collection_preview.mapper.dart';

@MappableClass()
class const CollectionPreview({
  required final Tag tag,
  required final List<VocabularyImage> images,
}) with CollectionPreviewMappable;
