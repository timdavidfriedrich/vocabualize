import 'package:dart_mappable/dart_mappable.dart';

part 'preferences.mapper.dart';

const _defaultReminderHour = 18;
const _defaultReminderMinute = 0;
const _plannedReminderDays = 7;

const defaultPreferences = Preferences(
  isTypeAnswerDisabled: false,
  areImagesHidden: false,
  practiceReminder: PracticeReminder(
    isEnabled: false,
    hour: _defaultReminderHour,
    minute: _defaultReminderMinute,
  ),
);

@MappableClass()
class const Preferences({
  required final bool isTypeAnswerDisabled,
  required final bool areImagesHidden,
  required final PracticeReminder practiceReminder,
}) with PreferencesMappable;

@MappableClass()
class const PracticeReminder({
  required final bool isEnabled,
  required final int hour,
  required final int minute,
}) with PracticeReminderMappable;

extension PracticeReminderExtensions on PracticeReminder {
  List<DateTime> plannedTimes({required DateTime? firstDueAt, required DateTime now}) {
    if (!isEnabled || firstDueAt == null) return const [];
    final localNow = now.toLocal();
    return [
      for (var day = 0; day <= _plannedReminderDays; day++)
        if (DateTime(localNow.year, localNow.month, localNow.day + day, hour, minute)
            case final at when at.isAfter(localNow) && !firstDueAt.isAfter(at))
          at,
    ].take(_plannedReminderDays).toList();
  }
}
