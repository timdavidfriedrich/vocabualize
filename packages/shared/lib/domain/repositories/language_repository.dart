import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';

abstract class LanguageRepository {
  Stream<AppResult<LanguageSetup?>> watchLanguageSetup();

  Future<AppResult<LanguageSetup?>> readLanguageSetup();

  Future<AppResult<()>> setUpLanguages({
    required Language main,
    required List<Language> learned,
  });

  Future<AppResult<()>> setMainLanguage(Language language);

  Future<AppResult<()>> saveLearnedLanguage(LearnedLanguage learnedLanguage);

  Future<AppResult<()>> removeLearnedLanguage(Language language);

  Future<AppResult<()>> selectLanguage(Language language);

  AppResult<Language> readDeviceLanguage();
}
