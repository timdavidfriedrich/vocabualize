import 'dart:async';
import 'dart:ui';

import 'package:core/error/app_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/reminder_kind.dart';
import 'package:shared/domain/entities/reminder_notification.dart';
import 'package:shared/domain/entities/reminder_plan.dart';
import 'package:shared/domain/repositories/reminder_repository.dart';
import 'package:shared/domain/use_cases/watch_reminder_plan_use_case.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';

const _fallbackLocale = Locale("en");

@injectable
class ReminderCubit extends Cubit<bool> {
  ReminderCubit(
    this._watchReminderPlan,
    this._reminderRepository,
  ) : super(true);

  final WatchReminderPlanUseCase _watchReminderPlan;
  final ReminderRepository _reminderRepository;
  final _scheduled = <ReminderKind, List<ReminderNotification>>{};
  StreamSubscription<AppResult<ReminderPlan>>? _subscription;
  Future<void> _scheduling = Future.value();

  void start() {
    _subscription ??= _watchReminderPlan().listen((result) {
      if (result case Success(data: final plan)) {
        emit(plan.isPermitted);
        _scheduling = _scheduling.then((_) => _schedule(plan));
      }
    });
  }

  Future<void> _schedule(ReminderPlan plan) async {
    final strings = _strings();
    if (plan.practiceTimes case final times?) {
      await _replace(ReminderKind.practice, [
        for (final at in times)
          ReminderNotification(
            at: at,
            title: strings.reminderPracticeTitle,
            body: strings.reminderPracticeMessage,
            channelName: strings.reminderPracticeChannel,
          ),
      ]);
    }
    if (plan.streakTimes case final times?) {
      await _replace(ReminderKind.streak, [
        for (final at in times) _streakReminder(strings, at: at, count: plan.streakCount),
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
      (title: strings.reminderStreakKeepTitle, body: strings.reminderStreakKeepMessage(count)),
      (title: strings.reminderStreakLookAroundTitle, body: strings.reminderStreakLookAroundMessage),
      (
        title: strings.reminderStreakQuickRoundTitle,
        body: strings.reminderStreakQuickRoundMessage(count),
      ),
      (title: strings.reminderStreakNearbyTitle, body: strings.reminderStreakNearbyMessage),
      (title: strings.reminderStreakInARowTitle(count), body: strings.reminderStreakInARowMessage),
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
    await _subscription?.cancel();
    return super.close();
  }
}
