import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class HomeState {
  final List<Vocabulary> vocabularies;
  final List<Tag> tags;
  final bool areImagesEnabled;

  const HomeState({
    required this.vocabularies,
    required this.tags,
    required this.areImagesEnabled,
  });

  HomeState copyWith({
    List<Vocabulary>? vocabularies,
    List<Tag>? tags,
    bool? areImagesEnabled,
  }) {
    return HomeState(
      vocabularies: vocabularies ?? this.vocabularies,
      tags: tags ?? this.tags,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
    );
  }
}
