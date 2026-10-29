import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

part 'vocabulary_filter.mapper.dart';

const emptyVocabularyFilter = VocabularyFilter(query: "", levels: {}, isDueOnly: false);

@MappableClass()
class const VocabularyFilter({
  required final String query,
  required final Set<VocabularyLevel> levels,
  required final bool isDueOnly,
}) with VocabularyFilterMappable;
