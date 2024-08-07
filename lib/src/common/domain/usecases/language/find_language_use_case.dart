import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';

class FindLanguageUseCase {
  final languageRepository = sl.get<LanguageRepository>();

  Future<Language?> call({String? translatorId, String? speechToTextId, String? textToSpeechId}) {
    return languageRepository.findLanguage(
      translatorId: translatorId,
      speechToTextId: speechToTextId,
      textToSpeechId: textToSpeechId,
    );
  }
}
