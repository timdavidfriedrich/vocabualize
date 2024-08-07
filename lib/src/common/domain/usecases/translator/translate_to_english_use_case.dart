import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

class TranslateToEnglishUseCase {
  final translatorRepository = sl.get<TranslatorRepository>();

  Future<String> call(String source) => translatorRepository.translateToEnglish(source);
}
