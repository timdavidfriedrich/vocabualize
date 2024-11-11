import 'package:vocabualize/src/common/domain/entities/language.dart';

class ChooseLanguagesState {
  final Language selectedSourceLanguage;
  final Language selectedTargetLanguage;

  const ChooseLanguagesState({
    required this.selectedSourceLanguage,
    required this.selectedTargetLanguage,
  });

  ChooseLanguagesState copyWith({
    Language? selectedSourceLanguage,
    Language? selectedTargetLanguage,
  }) {
    return ChooseLanguagesState(
      selectedSourceLanguage: selectedSourceLanguage ?? this.selectedSourceLanguage,
      selectedTargetLanguage: selectedTargetLanguage ?? this.selectedTargetLanguage,
    );
  }
}
