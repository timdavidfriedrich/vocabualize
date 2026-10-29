import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/app_info_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/preferences_mappers.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';
import 'package:shared/domain/repositories/settings_repository.dart';

@Injectable(as: SettingsRepository)
class const SettingsRepositoryImpl(
  final SettingLocalDataSource _dataSource,
  final AppInfoDataSource _appInfoDataSource,
) implements SettingsRepository {
  @override
  Stream<AppResult<LanguagePair?>> watchLanguagePair() {
    return _dataSource
        .watchLanguagePair()
        .map((setting) => setting?.toLanguagePair())
        .toAppResult();
  }

  @override
  Future<AppResult<LanguagePair?>> readLanguagePair() async {
    try {
      return Success((await _dataSource.readLanguagePair())?.toLanguagePair());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> setLanguagePair(LanguagePair pair) async {
    try {
      await _dataSource.insertSetting(
        _dataSource.createLanguagePair(
          value: pair.toLocalLanguagePairSetting().toJson(),
          changedAt: DateTime.now(),
        ),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  AppResult<Language> readDeviceLanguage() {
    try {
      return Success(_appInfoDataSource.deviceLanguageCode().toLanguage());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Stream<AppResult<Preferences>> watchPreferences() {
    return _dataSource
        .watchPreferences()
        .map((preferences) => preferences.toPreferences())
        .toAppResult();
  }

  @override
  Future<AppResult<Preferences>> readPreferences() async {
    try {
      return Success((await _dataSource.readPreferences()).toPreferences());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> setTypeAnswerDisabled(bool isDisabled) {
    return _savePreference(LocalPreferenceKey.typeAnswerDisabled, isDisabled.toPreferenceValue());
  }

  @override
  Future<AppResult<()>> setImagesHidden(bool areHidden) {
    return _savePreference(LocalPreferenceKey.imagesHidden, areHidden.toPreferenceValue());
  }

  @override
  Future<AppResult<()>> setAppearanceMode(AppearanceMode mode) {
    return _savePreference(LocalPreferenceKey.appearanceMode, mode.toPreferenceValue());
  }

  @override
  Future<AppResult<()>> setReminder(ReminderKind kind, DailyReminder reminder) {
    return _savePreference(
      kind.toLocalPreferenceKey(),
      reminder.toLocalDailyReminderSetting().toJson(),
    );
  }

  Future<AppResult<()>> _savePreference(LocalPreferenceKey key, String value) async {
    try {
      await _dataSource.savePreference(key, value, changedAt: DateTime.now());
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
