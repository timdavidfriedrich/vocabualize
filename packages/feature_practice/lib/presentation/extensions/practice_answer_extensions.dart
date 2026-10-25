import 'package:shared/domain/entities/practice_answer.dart';

extension PracticeGradeExtensions on PracticeAnswer? {
  bool allows(PracticeAnswer answer) => switch (this) {
    null => true,
    PracticeAnswer.forgot => answer == PracticeAnswer.forgot,
    PracticeAnswer.hard => answer == PracticeAnswer.forgot || answer == PracticeAnswer.hard,
    PracticeAnswer.good => answer == PracticeAnswer.hard || answer == PracticeAnswer.good,
    PracticeAnswer.easy => answer == PracticeAnswer.good || answer == PracticeAnswer.easy,
  };
}
