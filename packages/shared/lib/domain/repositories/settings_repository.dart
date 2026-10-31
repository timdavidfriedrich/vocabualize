import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

abstract class SettingsRepository {
  Stream<AppResult<Preferences>> watchPreferences();

  Future<AppResult<Preferences>> readPreferences();

  Future<AppResult<()>> setTypeAnswerDisabled(bool isDisabled);

  Future<AppResult<()>> setStrictCorrectionEnabled(bool isEnabled);

  Future<AppResult<()>> setImagesHidden(bool areHidden);

  Future<AppResult<()>> setAppearanceMode(AppearanceMode mode);

  Future<AppResult<()>> setDefaultGatherOption(DefaultGatherOption option);

  Future<AppResult<()>> setReminder(ReminderKind kind, DailyReminder reminder);
}
