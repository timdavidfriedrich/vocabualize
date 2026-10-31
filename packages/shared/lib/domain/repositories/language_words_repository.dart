import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_words_change.dart';

abstract class LanguageWordsRepository {
  Stream<AppResult<LanguageCoverage>> watchLanguageCoverage(Language language);

  Future<AppResult<LanguageWordsPreview>> previewChange(
    Language language,
    LanguageWordsChange change,
  );

  Future<AppResult<()>> applyChange(Language language, LanguageWordsChange change);

  Future<AppResult<()>> restartLanguage(Language language);

  Future<AppResult<()>> deleteLanguageWords(
    Language language, {
    required bool keepsTranslations,
  });
}
