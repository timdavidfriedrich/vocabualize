import 'dart:math';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/date_time_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/practice_button.dart';

const _shownLevels = [VocabularyLevel.beginner, VocabularyLevel.advanced, VocabularyLevel.expert];
const _manyAddedToday = 3;
const _manyWordsInTotal = 10;
const _roundButtonSize = Spacing.xxxl;
const _flagSize = Spacing.xl;
const _flagOverlap = Spacing.xxs;
const _progressHeight = Spacing.xxs;

class const StatusCard({
  super.key,
  required final VocabularyOverview _overview,
  required final Language _language,
  required final NewWordLimit? _newWordLimit,
  required final CustomPracticeSession? _customSession,
  required final List<Tag> _tags,
  required final VoidCallback _onCustomPracticeEnded,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.l),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_cheer(context), style: context.t.titleMedium),
          if (_doneMessage(context) case final doneMessage?) ...[
            const SizedBox(height: Spacing.xxs),
            Text(
              doneMessage,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: Spacing.m),
          Row(
            children: [
              _LevelStatistics(overview: _overview),
              const SizedBox(width: Spacing.m),
              Expanded(child: PracticeButton(count: _overview.practiceCountWith(_newWordLimit))),
            ],
          ),
          if (_customSession case final session?) ...[
            const SizedBox(height: Spacing.m),
            _CustomSessionCard(session: session, tags: _tags, onEnded: _onCustomPracticeEnded),
          ],
        ],
      ),
    );
  }

  String _cheer(BuildContext context) {
    final VocabularyOverview(:totalCount, :addedTodayCount) = _overview;
    final language = _language.toShortLabel(context);
    if (totalCount == 0) return context.s.homeStatusEmptyMessage;
    if (totalCount == 1 && addedTodayCount == 1) return context.s.homeStatusFirstWordMessage;
    final messages = [
      if (addedTodayCount >= _manyAddedToday)
        context.s.homeStatusAddedTodayMessage(addedTodayCount),
      if (totalCount >= _manyWordsInTotal)
        context.s.homeStatusManyWordsMessage(totalCount, language),
      if (totalCount == 1) context.s.homeStatusOnlyOneWordMessage,
      context.s.homeStatusDefaultMessage(totalCount, language),
    ];
    final seed = Object.hash(totalCount, addedTodayCount, DateUtils.dateOnly(DateTime.now()));
    return messages[Random(seed).nextInt(messages.length)];
  }

  String? _doneMessage(BuildContext context) => switch (_overview) {
    final overview when overview.practiceCountWith(_newWordLimit) > 0 => null,
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
      spacing: Spacing.s,
      children: [
        for (final level in _shownLevels)
          Column(
            spacing: Spacing.xxs,
            children: [
              Icon(Icons.circle, color: level.toColor(context)),
              Text(_overview.countOf(level).toCountLabel(context), style: context.t.titleMedium),
            ],
          ),
      ],
    );
  }
}

class const _CustomSessionCard({
  required final CustomPracticeSession _session,
  required final List<Tag> _tags,
  required final VoidCallback _onEnded,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final names = [
      for (final tag in _tags)
        if (_session.filter.tagIds.contains(tag.id)) tag.name,
    ];
    final total = _session.items.length;
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.primaryContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Row(
        children: [
          _RoundButton(
            icon: Icons.playlist_play_rounded,
            tooltip: context.s.homeCustomPracticeContinueButton,
            color: context.c.primary,
            iconColor: context.c.onPrimary,
            onPressed: context.continueCustomPractice,
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _FlagStack(languages: _session.filter.languages.toList()),
                    const SizedBox(width: Spacing.xs),
                    Expanded(
                      child: Text(
                        names.isEmpty ? context.s.customPracticeTitle : names.join(", "),
                        style: context.t.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  context.s.homeCustomPracticeProgress(_session.remainingCount, total),
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
                const SizedBox(height: Spacing.xs),
                LinearProgressIndicator(
                  value: total == 0 ? 0 : _session.doneCount / total,
                  minHeight: _progressHeight,
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  color: context.c.primary,
                  backgroundColor: context.c.outlineVariant,
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.m),
          _RoundButton(
            icon: Icons.close_rounded,
            tooltip: context.s.homeCustomPracticeEndButton,
            color: context.c.surfaceContainerHighest,
            iconColor: context.c.onSurface,
            onPressed: () => _end(context),
          ),
        ],
      ),
    );
  }

  Future<void> _end(BuildContext context) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(context.s.homeCustomPracticeEndTitle),
        content: Text(context.s.homeCustomPracticeEndMessage(_session.remainingCount)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.s.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(context.s.homeCustomPracticeEndButton),
          ),
        ],
      ),
    );
    if (isConfirmed == true) _onEnded();
  }
}

class const _FlagStack({
  required final List<Language> _languages,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const step = _flagSize - _flagOverlap;
    return SizedBox(
      height: _flagSize,
      width: _languages.isEmpty ? 0 : step * (_languages.length - 1) + _flagSize,
      child: Stack(
        children: [
          for (final (index, language) in _languages.indexed)
            Positioned(
              left: step * index,
              child: Container(
                width: _flagSize,
                height: _flagSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.c.surfaceContainerHighest,
                ),
                child: Text(language.toFlag(), style: context.t.labelSmall),
              ),
            ),
        ],
      ),
    );
  }
}

class const _RoundButton({
  required final IconData _icon,
  required final String _tooltip,
  required final Color _color,
  required final Color _iconColor,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _roundButtonSize,
      child: IconButton.filled(
        style: IconButton.styleFrom(backgroundColor: _color, foregroundColor: _iconColor),
        onPressed: _onPressed,
        tooltip: _tooltip,
        icon: Icon(_icon),
      ),
    );
  }
}
