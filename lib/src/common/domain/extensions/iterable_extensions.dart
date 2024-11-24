import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

extension VocabularyListExtensions on List<Vocabulary> {
  List<Vocabulary> filterBySearchTerm(String? searchTerm) {
    if (searchTerm == null || searchTerm.isEmpty) return this;
    return where((vocabulary) {
      return vocabulary.source.contains(searchTerm) ||
          vocabulary.target.contains(searchTerm);
    }).toList();
  }

  List<Vocabulary> filterByTag(Tag? tag) {
    if (tag == null) return this;
    return where((vocabulary) {
      return vocabulary.tagIds.contains(tag.id);
    }).toList();
  }
}

extension IterableExtensions<ElementType> on Iterable<ElementType> {
  Iterable<ElementType?> asNullable() {
    return cast<ElementType?>();
  }

  ElementType? firstWhereOrNull(bool Function(ElementType? element) condition) {
    return asNullable().firstWhere(condition, orElse: () => null);
  }
}
