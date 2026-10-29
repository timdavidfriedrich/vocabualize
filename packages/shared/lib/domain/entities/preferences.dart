import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

part 'preferences.mapper.dart';

const _defaultPracticeReminderHour = 18;
const _defaultStreakReminderHour = 20;
const _defaultReminderMinute = 0;
const _plannedReminderDays = 7;

const defaultPreferences = Preferences(
  isTypeAnswerDisabled: false,
  isStrictCorrectionEnabled: false,
  areImagesHidden: false,
  appearanceMode: AppearanceMode.system,
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
  required final DailyReminder practiceReminder,
  required final DailyReminder streakReminder,
}) with PreferencesMappable;

@MappableClass()
class const DailyReminder({
  required final bool isEnabled,
  required final int hour,
  required final int minute,
}) with DailyReminderMappable;

extension PreferencesExtensions on Preferences {
  DailyReminder reminderOf(ReminderKind kind) => switch (kind) {
    ReminderKind.practice => practiceReminder,
    ReminderKind.streak => streakReminder,
  };
}

extension DailyReminderExtensions on DailyReminder {
  List<DateTime> plannedPracticeTimes({required DateTime? firstDueAt, required DateTime now}) {
    if (!isEnabled || firstDueAt == null) return const [];
    final localNow = now.toLocal();
    return [
      for (var day = 0; day <= _plannedReminderDays; day++)
        if (DateTime(localNow.year, localNow.month, localNow.day + day, hour, minute) case final at
            when at.isAfter(localNow) && !firstDueAt.isAfter(at))
          at,
    ].take(_plannedReminderDays).toList();
  }

  List<DateTime> plannedTimesOn(List<DateTime> days, {required DateTime now}) {
    if (!isEnabled) return const [];
    final localNow = now.toLocal();
    return [
      for (final day in days)
        if (DateTime(day.year, day.month, day.day, hour, minute) case final at
            when at.isAfter(localNow))
          at,
    ];
  }
}
