import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/text_to_speech_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';

final setTargetLanguageUseCaseProvider = Provider((ref) {
  return SetTargetLanguageUseCase(
    textToSpeechRepository: ref.watch(textToSpeechRepositoryProvider),
  );
});

class SetTargetLanguageUseCase {
  final TextToSpeechRepository _textToSpeechRepository;

  const SetTargetLanguageUseCase({
    required TextToSpeechRepository textToSpeechRepository,
  }) : _textToSpeechRepository = textToSpeechRepository;

  Future<void> call(Language language) {
    return _textToSpeechRepository.setLanguage(language);
  }
}
