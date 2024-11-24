import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class HomeState {
  final bool isStillLoading;
  final List<Vocabulary> vocabularies;
  final List<Vocabulary> newVocabularies;
  final List<Tag> tags;
  final bool areImagesEnabled;

  const HomeState({
    this.isStillLoading = false,
    required this.vocabularies,
    required this.newVocabularies,
    required this.tags,
    required this.areImagesEnabled,
  });

  HomeState copyWith({
    bool isStillLoading = false,
    List<Vocabulary>? vocabularies,
    List<Vocabulary>? newVocabularies,
    List<Tag>? tags,
    bool? areImagesEnabled,
  }) {
    return HomeState(
      isStillLoading: isStillLoading,
      vocabularies: vocabularies ?? this.vocabularies,
      newVocabularies: newVocabularies ?? this.newVocabularies,
      tags: tags ?? this.tags,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
    );
  }
}
