import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

class TranslateUseCase {
  final translatorRepository = sl.get<TranslatorRepository>();

  Future<String> call(String source, {String? sourceLanguageId, String? targetLanguageId}) {
    return translatorRepository.translate(
      source,
      sourceLanguageId: sourceLanguageId,
      targetLanguageId: targetLanguageId,
    );
  }
}
