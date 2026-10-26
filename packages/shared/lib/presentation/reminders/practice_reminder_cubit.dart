import 'dart:async';
import 'dart:ui';

import 'package:core/error/app_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/reminder_notification.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/reminder_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';

const _fallbackLocale = Locale("en");

@injectable
class PracticeReminderCubit extends Cubit<bool> {
  PracticeReminderCubit(
    this._reminderRepository,
    this._settingsRepository,
    this._vocabularyRepository,
  ) : super(true);

  final ReminderRepository _reminderRepository;
  final SettingsRepository _settingsRepository;
  final VocabularyRepository _vocabularyRepository;
  final _subscriptions = <StreamSubscription<Object?>>[];
  Preferences? _preferences;
  VocabularyOverview? _overview;
  bool? _isPermitted;
  List<ReminderNotification>? _scheduled;
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
      _vocabularyRepository.watchVocabularyOverview().listen((result) {
        if (result case Success(:final data)) {
          _overview = data;
          _reschedule();
        }
      }),
    ]);
  }

  void _reschedule() {
    _scheduling = _scheduling.then((_) => _schedule());
  }

  Future<void> _schedule() async {
    final (isPermitted, preferences, overview) = (_isPermitted, _preferences, _overview);
    if (isPermitted == null || overview == null) return;
    final now = DateTime.now();
    final times = isPermitted
        ? (preferences ?? defaultPreferences).practiceReminder.plannedTimes(
            firstDueAt: overview.dueCount > 0 ? now : overview.nextDueAt,
            now: now,
          )
        : const <DateTime>[];
    final strings = _strings();
    final reminders = [
      for (final at in times)
        ReminderNotification(
          at: at,
          title: strings.reminderPracticeTitle,
          body: strings.reminderPracticeBody,
          channelName: strings.reminderPracticeChannel,
        ),
    ];
    if (listEquals(reminders, _scheduled)) return;
    if (await _reminderRepository.schedulePracticeReminders(reminders) case Success()) {
      _scheduled = reminders;
    }
  }

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
    return super.close();
  }
}
