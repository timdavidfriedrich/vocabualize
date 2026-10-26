import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/data/models/local_practice_reminder_setting.dart';
import 'package:shared/data/models/local_preference_key.dart';
import 'package:shared/domain/entities/preferences.dart';

const _trueValue = "true";
const _falseValue = "false";

extension LocalPreferencesMappers on Map<LocalPreferenceKey, String> {
  Preferences toPreferences() {
    return Preferences(
      isTypeAnswerDisabled: this[LocalPreferenceKey.typeAnswerDisabled] == _trueValue,
      areImagesHidden: this[LocalPreferenceKey.imagesHidden] == _trueValue,
      practiceReminder: switch (this[LocalPreferenceKey.practiceReminder]) {
        final String json => _practiceReminderFrom(json),
        null => defaultPreferences.practiceReminder,
      },
    );
  }

  PracticeReminder _practiceReminderFrom(String json) {
    try {
      return LocalPracticeReminderSettingMapper.fromJson(json).toPracticeReminder();
    } on MapperException {
      return defaultPreferences.practiceReminder;
    }
  }
}

extension LocalPracticeReminderSettingMappers on LocalPracticeReminderSetting {
  PracticeReminder toPracticeReminder() {
    return PracticeReminder(isEnabled: isEnabled, hour: hour, minute: minute);
  }
}

extension PracticeReminderMappers on PracticeReminder {
  LocalPracticeReminderSetting toLocalPracticeReminderSetting() {
    return LocalPracticeReminderSetting(isEnabled: isEnabled, hour: hour, minute: minute);
  }
}

extension PreferenceFlagMappers on bool {
  String toPreferenceValue() => this ? _trueValue : _falseValue;
}
