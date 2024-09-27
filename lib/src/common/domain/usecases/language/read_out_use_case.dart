import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/text_to_speech_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';

final readOutUseCaseProvider = Provider((ref) {
  return ReadOutUseCase(
    textToSpeechRepository: ref.watch(textToSpeechRepositoryProvider),
  );
});

class ReadOutUseCase {
  final TextToSpeechRepository _textToSpeechRepository;

  const ReadOutUseCase({
    required TextToSpeechRepository textToSpeechRepository,
  }) : _textToSpeechRepository = textToSpeechRepository;

  Future<void> call(Vocabulary vocabulary) {
    return _textToSpeechRepository.readOut(vocabulary);
  }
}
