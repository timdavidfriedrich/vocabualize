import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_info_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/language_setup_mappers.dart';
import 'package:shared/data/models/local_learned_language_setting.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';

@Injectable(as: LanguageRepository)
class const LanguageRepositoryImpl(
  final SettingLocalDataSource _dataSource,
  final AppInfoDataSource _appInfoDataSource,
) implements LanguageRepository {
  @override
  Stream<AppResult<LanguageSetup?>> watchLanguageSetup() {
    return _dataSource
        .watchLanguageSettings()
        .map((settings) => settings.toLanguageSetup())
        .toAppResult();
  }

  @override
  Future<AppResult<LanguageSetup?>> readLanguageSetup() async {
    try {
      return Success((await _dataSource.readLanguageSettings()).toLanguageSetup());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> setUpLanguages({
    required Language main,
    required List<Language> learned,
  }) async {
    try {
      final now = DateTime.now().toUtc();
      final existing = await _learnedSettings();
      await _dataSource.saveLanguageSettings(
        mainLanguage: main.toLanguageCode(),
        selectedLanguage: learned.firstOrNull?.toLanguageCode(),
        learnedLanguages: {
          for (final (index, language) in learned.indexed)
            language.toLanguageCode(): (existing[language.toLanguageCode()] ??
                    language.toLearnedLanguage().toLocalLearnedLanguageSetting(
                      addedAt: now.add(Duration(microseconds: index)),
                    ))
                .toJson(),
        },
        changedAt: now,
      );
      for (final languageCode in existing.keys) {
        if (!learned.any((language) => language.toLanguageCode() == languageCode)) {
          await _dataSource.deleteLearnedLanguage(languageCode);
        }
      }
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> setMainLanguage(Language language) {
    return _save(mainLanguage: language.toLanguageCode());
  }

  @override
  Future<AppResult<()>> saveLearnedLanguage(LearnedLanguage learnedLanguage) async {
    try {
      final languageCode = learnedLanguage.language.toLanguageCode();
      final addedAt = (await _learnedSettings())[languageCode]?.addedAt ?? DateTime.now().toUtc();
      return await _save(
        learnedLanguages: {
          languageCode: learnedLanguage.toLocalLearnedLanguageSetting(addedAt: addedAt).toJson(),
        },
      );
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> removeLearnedLanguage(Language language) async {
    try {
      await _dataSource.deleteLearnedLanguage(language.toLanguageCode());
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> selectLanguage(Language language) {
    return _save(selectedLanguage: language.toLanguageCode());
  }

  @override
  AppResult<Language> readDeviceLanguage() {
    try {
      return Success(_appInfoDataSource.deviceLocaleTag().toLanguage());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  Future<Map<String, LocalLearnedLanguageSetting>> _learnedSettings() async {
    final settings = await _dataSource.readLanguageSettings();
    final learned = [
      for (final value in settings.learnedLanguages) ?value.toLocalLearnedLanguageSetting(),
    ];
    return {for (final setting in learned) setting.language: setting};
  }

  Future<AppResult<()>> _save({
    String? mainLanguage,
    String? selectedLanguage,
    Map<String, String> learnedLanguages = const {},
  }) async {
    try {
      await _dataSource.saveLanguageSettings(
        mainLanguage: mainLanguage,
        selectedLanguage: selectedLanguage,
        learnedLanguages: learnedLanguages,
        changedAt: DateTime.now(),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
