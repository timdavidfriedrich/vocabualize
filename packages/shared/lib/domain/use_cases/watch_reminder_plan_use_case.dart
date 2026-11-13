import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_plan.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/extensions/stream_extensions.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/reminder_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:shared/domain/use_cases/watch_streak_use_case.dart';

@injectable
class const WatchReminderPlanUseCase(
  final ReminderRepository _reminderRepository,
  final SettingsRepository _settingsRepository,
  final VocabularyRepository _vocabularyRepository,
  final LanguageRepository _languageRepository,
  final WatchStreakUseCase _watchStreak,
) {
  Stream<AppResult<ReminderPlan>> call() {
    final settings = _reminderRepository.watchNotificationPermission().combineLatest(
      _settingsRepository.watchPreferences(),
      (permission, preferences) => (permission: permission, preferences: preferences),
    );
    final progress = _watchOverview().combineLatest(
      _watchStreak(),
      (overview, streak) => (overview: overview, streak: streak),
    );
    return settings.combineLatest(
      progress,
      (settings, progress) => switch (settings.permission) {
        Success(data: final isPermitted) => Success(
          _planOf(
            isPermitted: isPermitted,
            preferences: switch (settings.preferences) {
              Success(:final data) => data,
              Failure() => defaultPreferences,
            },
            overview: progress.overview,
            streak: progress.streak,
          ),
        ),
        Failure(:final error) => Failure(error),
      },
    );
  }

  Stream<AppResult<VocabularyOverview>> _watchOverview() {
    return _languageRepository
        .watchLanguageSetup()
        .map(
          (result) => switch (result) {
            Success(:final data) => Success({
              for (final learnedLanguage in data?.active ?? const <LearnedLanguage>[])
                learnedLanguage.language,
            }),
            Failure(:final error) => Failure<Set<Language>>(error),
          },
        )
        .distinct(_isSameSelection)
        .switchMap(
          (result) => switch (result) {
            Success(:final data) => _vocabularyRepository.watchVocabularyOverview(languages: data),
            Failure(:final error) => Stream.value(Failure(error)),
          },
        );
  }

  bool _isSameSelection(AppResult<Set<Language>> previous, AppResult<Set<Language>> next) {
    return switch ((previous, next)) {
      (Success(data: final previous), Success(data: final next)) =>
        previous.length == next.length && previous.containsAll(next),
      (_, _) => false,
    };
  }

  ReminderPlan _planOf({
    required bool isPermitted,
    required Preferences preferences,
    required AppResult<VocabularyOverview> overview,
    required AppResult<Streak> streak,
  }) {
    final now = DateTime.now().toUtc();
    return ReminderPlan(
      isPermitted: isPermitted,
      practiceTimes: switch (overview) {
        Success(:final data) when isPermitted => preferences.practiceReminder.plannedPracticeTimes(
          firstDueAt: data.dueCount > 0 ? now : data.nextDueAt,
          now: now,
        ),
        Success() => const [],
        Failure() => null,
      },
      streakTimes: switch (streak) {
        Success(:final data) when isPermitted => preferences.streakReminder.plannedTimesOn(
          data.daysAtRisk,
          now: now,
        ),
        Success() => const [],
        Failure() => null,
      },
      streakCount: switch (streak) {
        Success(:final data) => data.current,
        Failure() => 0,
      },
    );
  }
}
