import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class PractiseState {
  final int initialVocabularyCount;
  final List<Vocabulary> vocabulariesLeftToPractise;
  final bool isMultilingual;
  final bool isSolutionShown;
  final bool areImagesDisabled;

  const PractiseState({
    required this.initialVocabularyCount,
    required this.vocabulariesLeftToPractise,
    required this.isMultilingual,
    required this.isSolutionShown,
    required this.areImagesDisabled,
  });

  Vocabulary get currentVocabulary => vocabulariesLeftToPractise.first;

  PractiseState copyWith({
    int? initialVocabularyCount,
    List<Vocabulary>? vocabulariesLeftToPractise,
    bool? isMultilingual,
    bool? isSolutionShown,
    bool? areImagesDisabled,
  }) {
    return PractiseState(
      initialVocabularyCount: initialVocabularyCount ?? this.initialVocabularyCount,
      vocabulariesLeftToPractise: vocabulariesLeftToPractise ?? this.vocabulariesLeftToPractise,
      isMultilingual: isMultilingual ?? this.isMultilingual,
      isSolutionShown: isSolutionShown ?? this.isSolutionShown,
      areImagesDisabled: areImagesDisabled ?? this.areImagesDisabled,
    );
  }
}
