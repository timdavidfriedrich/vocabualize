import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class HomeState {
  final List<Vocabulary> vocabularies;
  final List<Vocabulary> newVocabularies;
  final List<Tag> tags;
  final bool areImagesEnabled;

  const HomeState({
    required this.vocabularies,
    required this.newVocabularies,
    required this.tags,
    required this.areImagesEnabled,
  });

  HomeState copyWith({
    List<Vocabulary>? vocabularies,
    List<Vocabulary>? newVocabularies,
    List<Tag>? tags,
    bool? areImagesEnabled,
  }) {
    return HomeState(
      vocabularies: vocabularies ?? this.vocabularies,
      newVocabularies: newVocabularies ?? this.newVocabularies,
      tags: tags ?? this.tags,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
    );
  }
}
