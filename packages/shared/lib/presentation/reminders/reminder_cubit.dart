import 'dart:async';
import 'dart:ui';

import 'package:core/error/app_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_kind.dart';
import 'package:shared/domain/entities/reminder_notification.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/reminder_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:shared/domain/use_cases/watch_streak_use_case.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';

const _fallbackLocale = Locale("en");

@injectable
class ReminderCubit extends Cubit<bool> {
  ReminderCubit(
    this._reminderRepository,
    this._settingsRepository,
    this._vocabularyRepository,
    this._languageRepository,
    this._watchStreak,
  ) : super(true);

  final ReminderRepository _reminderRepository;
  final SettingsRepository _settingsRepository;
  final VocabularyRepository _vocabularyRepository;
  final LanguageRepository _languageRepository;
  final WatchStreakUseCase _watchStreak;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _scheduled = <ReminderKind, List<ReminderNotification>>{};
  StreamSubscription<AppResult<VocabularyOverview>>? _overviewSubscription;
  Set<Language>? _activeLanguages;
  Preferences? _preferences;
  VocabularyOverview? _overview;
  Streak? _streak;
  bool? _isPermitted;
  Future<void> _scheduling = Future.value();

  void start() {
    if (_subscriptions.isNotEmpty) return;
    _subscriptions.addAll([
      _reminderRepository.watchNotificationPermission().listen((result) {
        if (result case Success(:final data)) {
          _isPermitted = data;
          emit(data);
          _reschedule();
        }
      }),
      _settingsRepository.watchPreferences().listen((result) {
        if (result case Success(:final data)) {
          _preferences = data;
          _reschedule();
        }
      }),
      _languageRepository.watchLanguageSetup().listen((result) {
        if (result case Success(:final data)) _watchOverview(data);
      }),
      _watchStreak().listen((result) {
        if (result case Success(:final data)) {
          _streak = data;
          _reschedule();
        }
      }),
    ]);
  }

  void _watchOverview(LanguageSetup? setup) {
    final languages = {
      for (final learnedLanguage in setup?.active ?? const <LearnedLanguage>[])
        learnedLanguage.language,
    };
    if (setEquals(languages, _activeLanguages)) return;
    _activeLanguages = languages;
    unawaited(_overviewSubscription?.cancel());
    _overviewSubscription = _vocabularyRepository
        .watchVocabularyOverview(languages: languages)
        .listen((result) {
          if (result case Success(:final data)) {
            _overview = data;
            _reschedule();
          }
        });
  }

  void _reschedule() {
    _scheduling = _scheduling.then((_) => _schedule());
  }

  Future<void> _schedule() async {
    final isPermitted = _isPermitted;
    if (isPermitted == null) return;
    final preferences = _preferences ?? defaultPreferences;
    final strings = _strings();
    final now = DateTime.now();
    if (_overview case final overview?) {
      await _replace(ReminderKind.practice, [
        if (isPermitted)
          for (final at in preferences.practiceReminder.plannedPracticeTimes(
            firstDueAt: overview.dueCount > 0 ? now : overview.nextDueAt,
            now: now,
          ))
            ReminderNotification(
              at: at,
              title: strings.reminderPracticeTitle,
              body: strings.reminderPracticeBody,
              channelName: strings.reminderPracticeChannel,
            ),
      ]);
    }
    if (_streak case final streak?) {
      await _replace(ReminderKind.streak, [
        if (isPermitted)
          for (final at in preferences.streakReminder.plannedTimesOn(streak.daysAtRisk, now: now))
            _streakReminder(strings, at: at, count: streak.current),
      ]);
    }
  }

  Future<void> _replace(ReminderKind kind, List<ReminderNotification> reminders) async {
    if (listEquals(reminders, _scheduled[kind])) return;
    if (await _reminderRepository.scheduleReminders(kind, reminders) case Success()) {
      _scheduled[kind] = reminders;
    }
  }

  ReminderNotification _streakReminder(
    AppLocalizations strings, {
    required DateTime at,
    required int count,
  }) {
    final variants = [
      (title: strings.reminderStreakKeepTitle, body: strings.reminderStreakKeepBody(count)),
      (title: strings.reminderStreakLookAroundTitle, body: strings.reminderStreakLookAroundBody),
      (
        title: strings.reminderStreakQuickRoundTitle,
        body: strings.reminderStreakQuickRoundBody(count),
      ),
      (title: strings.reminderStreakNearbyTitle, body: strings.reminderStreakNearbyBody),
      (title: strings.reminderStreakInARowTitle(count), body: strings.reminderStreakInARowBody),
    ];
    final variant = variants[_dayNumber(at) % variants.length];
    return ReminderNotification(
      at: at,
      title: variant.title,
      body: variant.body,
      channelName: strings.reminderStreakChannel,
    );
  }

  int _dayNumber(DateTime at) =>
      DateTime.utc(at.year, at.month, at.day).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;

  AppLocalizations _strings() {
    final deviceLocale = PlatformDispatcher.instance.locale;
    final locale = AppLocalizations.supportedLocales.firstWhere(
      (supported) => supported.languageCode == deviceLocale.languageCode,
      orElse: () => _fallbackLocale,
    );
    return lookupAppLocalizations(locale);
  }

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _overviewSubscription?.cancel();
    return super.close();
  }
}
