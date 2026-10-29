import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

abstract class SettingsRepository {
  Stream<AppResult<LanguagePair?>> watchLanguagePair();

  Future<AppResult<LanguagePair?>> readLanguagePair();

  Future<AppResult<()>> setLanguagePair(LanguagePair pair);

  AppResult<Language> readDeviceLanguage();

  Stream<AppResult<Preferences>> watchPreferences();

  Future<AppResult<Preferences>> readPreferences();

  Future<AppResult<()>> setTypeAnswerDisabled(bool isDisabled);

  Future<AppResult<()>> setImagesHidden(bool areHidden);

  Future<AppResult<()>> setAppearanceMode(AppearanceMode mode);

  Future<AppResult<()>> setReminder(ReminderKind kind, DailyReminder reminder);
}
