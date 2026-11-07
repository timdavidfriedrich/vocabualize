import 'package:flutter/material.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension PracticeGradeExtensions on PracticeAnswer? {
  bool allows(PracticeAnswer answer) => switch (this) {
    null => true,
    PracticeAnswer.forgot => answer == PracticeAnswer.forgot,
    PracticeAnswer.hard => answer == PracticeAnswer.forgot || answer == PracticeAnswer.hard,
    PracticeAnswer.good => answer == PracticeAnswer.hard || answer == PracticeAnswer.good,
    PracticeAnswer.easy => answer == PracticeAnswer.good || answer == PracticeAnswer.easy,
  };

  Color? toGradeColor(BuildContext context) => switch (this) {
    PracticeAnswer.forgot => context.levels.novice,
    PracticeAnswer.hard => context.levels.beginner,
    PracticeAnswer.good => context.levels.advanced,
    PracticeAnswer.easy => context.levels.expert,
    null => null,
  };
}
