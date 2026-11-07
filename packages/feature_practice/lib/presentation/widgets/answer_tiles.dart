import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _tintOpacity = 0.15;
const _textMaxLines = 3;

class const AnswerTiles({
  super.key,
  required final String _answer,
  required final String _solution,
  required final PracticeAnswer? _grade,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final answerColor = _grade.toGradeColor(context) ?? context.levels.beginner;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Tile(
            label: context.s.practiceAnswerLabel,
            text: _answer,
            tint: answerColor,
            labelColor: answerColor,
          ),
          const SizedBox(height: Spacing.xxxs),
          _Tile(
            label: context.s.practiceSolutionLabel,
            text: _solution,
            tint: context.levels.expert,
            labelColor: context.status.success,
          ),
        ],
      ),
    );
  }
}

class const _Tile({
  required final String _label,
  required final String _text,
  required final Color _tint,
  required final Color _labelColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _tint.withValues(alpha: _tintOpacity),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_label, style: context.t.labelLarge?.copyWith(color: _labelColor)),
            Text(
              _text,
              style: context.t.bodyLarge,
              maxLines: _textMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
