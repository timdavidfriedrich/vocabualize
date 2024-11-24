import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class PractiseState {
  final int initialVocabularyCount;
  final List<Vocabulary> vocabulariesLeft;
  final bool isMultilingual;
  final bool isSolutionShown;
  final bool areImagesEnabled;

  const PractiseState({
    required this.initialVocabularyCount,
    required this.vocabulariesLeft,
    required this.isMultilingual,
    required this.isSolutionShown,
    required this.areImagesEnabled,
  });

  Vocabulary get currentVocabulary => vocabulariesLeft.first;
  bool get isDone => vocabulariesLeft.isEmpty;

  PractiseState copyWith({
    int? initialVocabularyCount,
    List<Vocabulary>? vocabulariesLeftToPractise,
    bool? isMultilingual,
    bool? isSolutionShown,
    bool? areImagesEnabled,
  }) {
    return PractiseState(
      initialVocabularyCount:
          initialVocabularyCount ?? this.initialVocabularyCount,
      vocabulariesLeft: vocabulariesLeftToPractise ?? this.vocabulariesLeft,
      isMultilingual: isMultilingual ?? this.isMultilingual,
      isSolutionShown: isSolutionShown ?? this.isSolutionShown,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
    );
  }
}
