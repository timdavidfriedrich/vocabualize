import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_words_change.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';

@injectable
class const AddLearnedLanguageUseCase(
  final LanguageRepository _languageRepository,
  final LanguageWordsRepository _languageWordsRepository,
) {
  Future<AppResult<()>> call({
    required Language language,
    required NewWordLimit newWords,
    required LanguageWordsChange? words,
  }) async {
    final saved = await _languageRepository.saveLearnedLanguage(
      language.toLearnedLanguage().copyWith(newWords: newWords),
    );
    if (saved case Failure(:final error)) return Failure(error);
    if (words != null) {
      final applied = await _languageWordsRepository.applyChange(language, words);
      if (applied case Failure(:final error)) return Failure(error);
    }
    return _languageRepository.selectLanguage(language);
  }
}
