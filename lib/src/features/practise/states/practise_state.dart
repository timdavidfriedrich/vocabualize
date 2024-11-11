import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class PractiseState {
  final int initialVocabularyCount;
  final List<Vocabulary> vocabulariesLeftToPractise;
  final bool isMultilingual;
  final bool isSolutionShown;
  final bool areImagesEnabled;

  const PractiseState({
    required this.initialVocabularyCount,
    required this.vocabulariesLeftToPractise,
    required this.isMultilingual,
    required this.isSolutionShown,
    required this.areImagesEnabled,
  });

  Vocabulary get currentVocabulary => vocabulariesLeftToPractise.first;
  bool get isDone => vocabulariesLeftToPractise.isEmpty;

  PractiseState copyWith({
    int? initialVocabularyCount,
    List<Vocabulary>? vocabulariesLeftToPractise,
    bool? isMultilingual,
    bool? isSolutionShown,
    bool? areImagesEnabled,
  }) {
    return PractiseState(
      initialVocabularyCount: initialVocabularyCount ?? this.initialVocabularyCount,
      vocabulariesLeftToPractise: vocabulariesLeftToPractise ?? this.vocabulariesLeftToPractise,
      isMultilingual: isMultilingual ?? this.isMultilingual,
      isSolutionShown: isSolutionShown ?? this.isSolutionShown,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
    );
  }
}
