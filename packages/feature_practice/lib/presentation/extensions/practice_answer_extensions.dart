import 'package:flutter/material.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _tintOpacity = 0.15;

extension PracticeGradeExtensions on PracticeAnswer? {
  bool suggests(PracticeAnswer answer) => switch (this) {
    null => false,
    PracticeAnswer.forgot => answer == PracticeAnswer.forgot,
    PracticeAnswer.hard => answer == PracticeAnswer.forgot || answer == PracticeAnswer.hard,
    PracticeAnswer.good => answer == PracticeAnswer.hard || answer == PracticeAnswer.good,
    PracticeAnswer.easy => answer == PracticeAnswer.good || answer == PracticeAnswer.easy,
  };

  Color? toGradeColor(BuildContext context) => this?.toColor(context);
}

extension PracticeAnswerColorExtensions on PracticeAnswer {
  Color toColor(BuildContext context) => switch (this) {
    PracticeAnswer.forgot => context.levels.novice,
    PracticeAnswer.hard => context.levels.beginner,
    PracticeAnswer.good => context.levels.advanced,
    PracticeAnswer.easy => context.levels.expert,
  };

  Color toTint(BuildContext context) =>
      Color.alphaBlend(toColor(context).withValues(alpha: _tintOpacity), context.c.surface);

  Color toTintTextColor(BuildContext context) => switch (this) {
    PracticeAnswer.forgot => context.c.onPrimaryContainer,
    PracticeAnswer.hard => context.c.onErrorContainer,
    PracticeAnswer.good => context.status.warning,
    PracticeAnswer.easy => context.status.success,
  };
}
