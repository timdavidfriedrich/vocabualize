import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/speech_to_text_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/speech_to_text_repository.dart';

final recordSpeechUseCaseProvider = Provider((ref) {
  return RecordSpeechUseCase(
    speechToTextRepository: ref.watch(speechToTextRepositoryProvider),
  );
});

class RecordSpeechUseCase {
  final SpeechToTextRepository speechToTextRepository;

  const RecordSpeechUseCase({
    required this.speechToTextRepository,
  });

  Future<void> call() {
    return speechToTextRepository.record();
  }
}
