import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';

@injectable
class const DeleteLearnedLanguageUseCase(
  final LanguageRepository _languageRepository,
  final LanguageWordsRepository _languageWordsRepository,
) {
  Future<AppResult<()>> call(Language language) async {
    final setupResult = await _languageRepository.readLanguageSetup();
    if (setupResult case Failure(:final error)) return Failure(error);
    final isStillShown = switch (setupResult) {
      Success(data: final setup?) =>
        setup.main == language ||
            setup.learned.any(
              (learned) => learned.language != language && learned.askMeIn == language,
            ),
      Success() || Failure() => false,
    };
    final removed = await _languageRepository.removeLearnedLanguage(language);
    if (removed case Failure(:final error)) return Failure(error);
    return _languageWordsRepository.deleteLanguageWords(
      language,
      keepsTranslations: isStillShown,
    );
  }
}
