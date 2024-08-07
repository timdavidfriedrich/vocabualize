import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';

class GetAvailableLanguagesUseCase {
  final languageRepository = sl.get<LanguageRepository>();

  Future<List<Language>> call() {
    return languageRepository.getLangauges();
  }
}
