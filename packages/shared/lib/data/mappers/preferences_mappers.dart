import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/data/models/local_daily_reminder_setting.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

const _trueValue = "true";
const _falseValue = "false";
const _appearanceSystem = "system";
const _appearanceLight = "light";
const _appearanceDark = "dark";
const _gatherNone = "none";
const _gatherScan = "scan";
const _gatherWrite = "write";

extension LocalPreferencesMappers on Map<LocalPreferenceKey, String> {
  Preferences toPreferences() {
    return Preferences(
      isTypeAnswerDisabled: this[LocalPreferenceKey.typeAnswerDisabled] == _trueValue,
      isStrictCorrectionEnabled: this[LocalPreferenceKey.strictCorrectionEnabled] == _trueValue,
      areImagesHidden: this[LocalPreferenceKey.imagesHidden] == _trueValue,
      appearanceMode: switch (this[LocalPreferenceKey.appearanceMode]) {
        _appearanceLight => AppearanceMode.light,
        _appearanceDark => AppearanceMode.dark,
        _ => AppearanceMode.system,
      },
      defaultGatherOption: switch (this[LocalPreferenceKey.defaultGatherOption]) {
        _gatherScan => DefaultGatherOption.scan,
        _gatherWrite => DefaultGatherOption.write,
        _ => DefaultGatherOption.none,
      },
      practiceReminder: _reminderOf(ReminderKind.practice),
      streakReminder: _reminderOf(ReminderKind.streak),
    );
  }

  DailyReminder _reminderOf(ReminderKind kind) {
    final fallback = defaultPreferences.reminderOf(kind);
    final json = this[kind.toLocalPreferenceKey()];
    if (json == null) return fallback;
    try {
      return LocalDailyReminderSettingMapper.fromJson(json).toDailyReminder();
    } on MapperException {
      return fallback;
    }
  }
}

extension ReminderKindPreferenceMappers on ReminderKind {
  LocalPreferenceKey toLocalPreferenceKey() => switch (this) {
    ReminderKind.practice => LocalPreferenceKey.practiceReminder,
    ReminderKind.streak => LocalPreferenceKey.streakReminder,
  };
}

extension LocalDailyReminderSettingMappers on LocalDailyReminderSetting {
  DailyReminder toDailyReminder() {
    return DailyReminder(isEnabled: isEnabled, hour: hour, minute: minute);
  }
}

extension DailyReminderMappers on DailyReminder {
  LocalDailyReminderSetting toLocalDailyReminderSetting() {
    return LocalDailyReminderSetting(isEnabled: isEnabled, hour: hour, minute: minute);
  }
}

extension PreferenceFlagMappers on bool {
  String toPreferenceValue() => this ? _trueValue : _falseValue;
}

extension AppearanceModeMappers on AppearanceMode {
  String toPreferenceValue() => switch (this) {
    AppearanceMode.system => _appearanceSystem,
    AppearanceMode.light => _appearanceLight,
    AppearanceMode.dark => _appearanceDark,
  };
}

extension DefaultGatherOptionMappers on DefaultGatherOption {
  String toPreferenceValue() => switch (this) {
    DefaultGatherOption.none => _gatherNone,
    DefaultGatherOption.scan => _gatherScan,
    DefaultGatherOption.write => _gatherWrite,
  };
}
