import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';

class SetTargetLanguageUseCase {
  final textToSpeechRepository = sl.get<TextToSpeechRepository>();

  Future<void> call(Language language) {
    return textToSpeechRepository.setLanguage(language);
  }
}