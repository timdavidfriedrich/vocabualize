import 'package:vocabualize/src/common/domain/entities/tag.dart';

class FilterOptions {
  final String? searchTerm;
  final Tag? tag;

  const FilterOptions({
    this.searchTerm,
    this.tag,
  });
}
