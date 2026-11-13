import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _relativeDaysLimit = 7;

extension DateTimeExtensions on DateTime {
  String toNextDueLabel(BuildContext context) {
    final local = toLocal();
    return DateUtils.isSameDay(local, DateTime.now())
        ? context.s.homeNextDueTodayMessage(DateFormat.jm(context.localeTag).format(local))
        : context.s.homeNextDueLaterMessage(DateFormat.MMMEd(context.localeTag).format(local));
  }

  String toReappearsLabel(BuildContext context) {
    return switch (difference(DateTime.now().toUtc())) {
      Duration(isNegative: true) => context.s.vocabularyReappearsNow,
      Duration(inMinutes: < 1) => context.s.vocabularyReappearsLessThanMinute,
      Duration(:final inMinutes, inHours: < 1) => context.s.vocabularyReappearsInMinutes(inMinutes),
      Duration(:final inHours, inDays: < 1) => context.s.vocabularyReappearsInHours(inHours),
      Duration(:final inDays) when inDays <= _relativeDaysLimit =>
        context.s.vocabularyReappearsInDays(inDays),
      Duration() => DateFormat.yMd(context.localeTag).add_jm().format(toLocal()),
    };
  }

  String toDateLabel(BuildContext context) => DateFormat.yMd(context.localeTag).format(toLocal());
}
