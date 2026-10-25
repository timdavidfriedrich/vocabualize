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
          Text(
            _message(context),
            style: context.t.bodyLarge,
            textAlign: TextAlign.left,
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

  String _message(BuildContext context) {
    final (:fact, :detail) = switch (_overview) {
      VocabularyOverview(:final dueCount, :final totalCount) when dueCount > 0 => (
        fact: context.s.homeDueMessage(dueCount),
        detail: context.s.homeTotalWordsMessage(totalCount),
      ),
      VocabularyOverview(nextDueAt: final nextDueAt?) => (
        fact: context.s.homeAllDoneMessage,
        detail: nextDueAt.toNextDueLabel(context),
      ),
      VocabularyOverview(:final totalCount) => (
        fact: context.s.homeAllDoneMessage,
        detail: context.s.homeTotalWordsMessage(totalCount),
      ),
    };
    return "$fact\n$detail";
  }
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
