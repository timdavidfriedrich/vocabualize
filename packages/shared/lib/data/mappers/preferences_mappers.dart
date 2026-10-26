import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/data/models/local_daily_reminder_setting.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

const _trueValue = "true";
const _falseValue = "false";

extension LocalPreferencesMappers on Map<LocalPreferenceKey, String> {
  Preferences toPreferences() {
    return Preferences(
      isTypeAnswerDisabled: this[LocalPreferenceKey.typeAnswerDisabled] == _trueValue,
      areImagesHidden: this[LocalPreferenceKey.imagesHidden] == _trueValue,
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
