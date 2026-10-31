import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/tag.dart';

part 'language_coverage.mapper.dart';

@MappableClass()
class const LanguageCoverage({
  required final int totalCount,
  required final int inLanguageCount,
  required final List<CollectionCoverage> collections,
  required final int untaggedCount,
  required final int untaggedInLanguageCount,
}) with LanguageCoverageMappable;

@MappableClass()
class const CollectionCoverage({
  required final Tag tag,
  required final int totalCount,
  required final int inLanguageCount,
}) with CollectionCoverageMappable;
