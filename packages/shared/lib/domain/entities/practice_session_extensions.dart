import 'package:shared/domain/entities/practice_session.dart';

extension CustomPracticeSessionExtensions on CustomPracticeSession {
  int get remainingCount => items.length - doneCount;
}

extension CustomPracticePlanExtensions on CustomPracticePlan {
  CustomPracticeFilter get filter => CustomPracticeFilter(
    languages: {for (final plan in languages) plan.language},
    tagIds: tagIds,
  );
}
