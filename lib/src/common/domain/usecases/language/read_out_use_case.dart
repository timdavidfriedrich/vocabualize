import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';

class ReadOutUseCase {
  final _textToSpeechRepository = sl.get<TextToSpeechRepository>();

  Future<void> call(Vocabulary vocabulary) {
    return _textToSpeechRepository.readOut(vocabulary);
  }
}
