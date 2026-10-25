import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _relativeDaysLimit = 7;

extension DateTimeExtensions on DateTime {
  String toNextDueLabel(BuildContext context) {
    final local = toLocal();
    final locale = _locale(context);
    return DateUtils.isSameDay(local, DateTime.now())
        ? context.s.homeNextDueTodayMessage(DateFormat.jm(locale).format(local))
        : context.s.homeNextDueLaterMessage(DateFormat.MMMEd(locale).format(local));
  }

  String toReappearsLabel(BuildContext context) {
    return switch (difference(DateTime.now().toUtc())) {
      Duration(isNegative: true) => context.s.vocabularyReappearsNow,
      Duration(inMinutes: < 1) => context.s.vocabularyReappearsLessThanMinute,
      Duration(:final inMinutes, inHours: < 1) => context.s.vocabularyReappearsInMinutes(inMinutes),
      Duration(:final inHours, inDays: < 1) => context.s.vocabularyReappearsInHours(inHours),
      Duration(:final inDays) when inDays <= _relativeDaysLimit =>
        context.s.vocabularyReappearsInDays(inDays),
      Duration() => DateFormat.yMd(_locale(context)).add_jm().format(toLocal()),
    };
  }

  String toDateLabel(BuildContext context) => DateFormat.yMd(_locale(context)).format(toLocal());

  String _locale(BuildContext context) => Localizations.localeOf(context).toLanguageTag();
}
