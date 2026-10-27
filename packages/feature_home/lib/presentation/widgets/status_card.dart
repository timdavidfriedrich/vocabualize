import 'dart:math';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/date_time_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';
import 'package:shared/presentation/widgets/practice_button.dart';

const _shownLevels = [VocabularyLevel.beginner, VocabularyLevel.advanced, VocabularyLevel.expert];
const _manyAddedToday = 3;
const _manyWordsInTotal = 10;

class const StatusCard({
  super.key,
  required final VocabularyOverview _overview,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.xl),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_cheer(context), style: context.t.bodyLarge),
          const SizedBox(height: Spacing.xxs),
          Text(
            _facts(context),
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(height: Spacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LevelStatistics(overview: _overview),
              PracticeButton(dueCount: _overview.dueCount),
            ],
          ),
        ],
      ),
    );
  }

  String _cheer(BuildContext context) {
    final VocabularyOverview(:totalCount, :addedTodayCount) = _overview;
    if (totalCount == 0) return context.s.homeStatusEmptyMessage;
    if (totalCount == 1 && addedTodayCount == 1) return context.s.homeStatusFirstWordMessage;
    final messages = [
      if (addedTodayCount >= _manyAddedToday)
        context.s.homeStatusAddedTodayMessage(addedTodayCount),
      if (totalCount >= _manyWordsInTotal) context.s.homeStatusManyWordsMessage(totalCount),
      if (totalCount == 1) context.s.homeStatusOnlyOneWordMessage,
      context.s.homeStatusDefaultMessage(totalCount),
    ];
    final seed = Object.hash(totalCount, addedTodayCount, DateUtils.dateOnly(DateTime.now()));
    return messages[Random(seed).nextInt(messages.length)];
  }

  String _facts(BuildContext context) => switch (_overview) {
    VocabularyOverview(:final dueCount) when dueCount > 0 => context.s.homeDueMessage(dueCount),
    VocabularyOverview(nextDueAt: final nextDueAt?) =>
      "${context.s.homeAllDoneMessage}\n${nextDueAt.toNextDueLabel(context)}",
    VocabularyOverview() => context.s.homeAllDoneMessage,
  };
}

class const _LevelStatistics({
  required final VocabularyOverview _overview,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: Spacing.s,
      children: [
        for (final level in _shownLevels)
          Column(
            children: [
              Icon(Icons.circle, color: level.toColor(context)),
              Text(_overview.countOf(level).toCountLabel(context), style: context.t.bodyLarge),
            ],
          ),
      ],
    );
  }
}
