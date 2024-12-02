import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class CollectionState {
  final Tag tag;
  final List<Vocabulary> tagVocabularies;
  final bool areImagesEnabled;

  CollectionState({
    required this.tag,
    required this.tagVocabularies,
    required this.areImagesEnabled,
  });

  CollectionState copyWith({
    Tag? tag,
    List<Vocabulary>? tagVocabularies,
  }) {
    return CollectionState(
      tag: tag ?? this.tag,
      tagVocabularies: tagVocabularies ?? this.tagVocabularies,
      areImagesEnabled: areImagesEnabled,
    );
  }
}
