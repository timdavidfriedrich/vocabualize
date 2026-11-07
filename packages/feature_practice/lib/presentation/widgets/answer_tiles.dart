import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _textMaxLines = 3;

class const AnswerTiles({
  super.key,
  required final String _answer,
  required final String _solution,
  required final PracticeAnswer _grade,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isCorrect = _grade == PracticeAnswer.easy;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Tile(
            label: context.s.practiceAnswerLabel,
            text: _answer,
            grade: _grade,
            isCorrect: isCorrect,
          ),
          if (!isCorrect) ...[
            const SizedBox(height: Spacing.xxxs),
            _Tile(
              label: context.s.practiceSolutionLabel,
              text: _solution,
              grade: PracticeAnswer.easy,
              isCorrect: false,
            ),
          ],
        ],
      ),
    );
  }
}

class const _Tile({
  required final String _label,
  required final String _text,
  required final PracticeAnswer _grade,
  required final bool _isCorrect,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _grade.toTint(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.s),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _label,
                    style: context.t.labelLarge?.copyWith(color: _grade.toTintTextColor(context)),
                  ),
                  Text(
                    _text,
                    style: context.t.bodyLarge,
                    maxLines: _textMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (_isCorrect) ...[
              const SizedBox(width: Spacing.s),
              SizedBox.square(
                dimension: Spacing.xxl,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _grade.toColor(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: Spacing.iconS,
                    color: context.c.onPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
