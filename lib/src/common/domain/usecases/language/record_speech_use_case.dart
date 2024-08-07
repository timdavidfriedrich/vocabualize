import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/speech_to_text_repository.dart';

class RecordSpeechUseCase {
  final speechToTextRepository = sl.get<SpeechToTextRepository>();

  Future<void> call() {
    return speechToTextRepository.record();
  }
}
