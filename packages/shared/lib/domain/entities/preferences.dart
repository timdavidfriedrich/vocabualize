import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/default_gather_option.dart';

part 'preferences.mapper.dart';

const _defaultPracticeReminderHour = 18;
const _defaultStreakReminderHour = 20;
const _defaultReminderMinute = 0;

const defaultPreferences = Preferences(
  isTypeAnswerDisabled: false,
  isStrictCorrectionEnabled: false,
  areImagesHidden: false,
  appearanceMode: AppearanceMode.system,
  defaultGatherOption: DefaultGatherOption.none,
  practiceReminder: DailyReminder(
    isEnabled: false,
    hour: _defaultPracticeReminderHour,
    minute: _defaultReminderMinute,
  ),
  streakReminder: DailyReminder(
    isEnabled: false,
    hour: _defaultStreakReminderHour,
    minute: _defaultReminderMinute,
  ),
);

@MappableClass()
class const Preferences({
  required final bool isTypeAnswerDisabled,
  required final bool isStrictCorrectionEnabled,
  required final bool areImagesHidden,
  required final AppearanceMode appearanceMode,
  required final DefaultGatherOption defaultGatherOption,
  required final DailyReminder practiceReminder,
  required final DailyReminder streakReminder,
}) with PreferencesMappable;

@MappableClass()
class const DailyReminder({
  required final bool isEnabled,
  required final int hour,
  required final int minute,
}) with DailyReminderMappable;
