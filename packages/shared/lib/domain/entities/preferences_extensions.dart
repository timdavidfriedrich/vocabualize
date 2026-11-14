import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';

const _plannedReminderDays = 7;

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
