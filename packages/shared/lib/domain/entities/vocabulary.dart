import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'vocabulary.mapper.dart';

@MappableClass()
class const Vocabulary({
  required final String id,
  required final String source,
  required final String target,
  required final Language sourceLanguage,
  required final Language targetLanguage,
  required final double level,
  required final bool isNovice,
  required final int intervalMinutes,
  required final double ease,
  required final DateTime nextReviewAt,
  required final VocabularyImage image,
  required final Set<String> tagIds,
  required final DateTime createdAt,
}) with VocabularyMappable;
