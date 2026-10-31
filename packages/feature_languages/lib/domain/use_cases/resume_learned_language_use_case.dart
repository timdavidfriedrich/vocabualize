import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';

@injectable
class const ResumeLearnedLanguageUseCase(
  final LanguageRepository _languageRepository,
  final LanguageWordsRepository _languageWordsRepository,
) {
  Future<AppResult<()>> call(
    LearnedLanguage learnedLanguage, {
    required bool startsOver,
  }) async {
    if (startsOver) {
      final restarted = await _languageWordsRepository.restartLanguage(learnedLanguage.language);
      if (restarted case Failure(:final error)) return Failure(error);
    }
    final saved = await _languageRepository.saveLearnedLanguage(
      learnedLanguage.copyWith(isPaused: false),
    );
    if (saved case Failure(:final error)) return Failure(error);
    return _languageRepository.selectLanguage(learnedLanguage.language);
  }
}
