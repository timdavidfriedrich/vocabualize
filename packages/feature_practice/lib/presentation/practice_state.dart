import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/vocabulary.dart';

part 'practice_state.mapper.dart';

@MappableClass()
sealed class PracticeState with PracticeStateMappable {
  const PracticeState();
}

@MappableClass()
class const PracticeLoading() extends PracticeState with PracticeLoadingMappable;

@MappableClass()
class const PracticeActive({
  required final DateTime dueBy,
  required final String? tagId,
  required final int totalCount,
  required final int doneCount,
  required final List<Vocabulary> queue,
  required final bool showsLanguages,
  required final bool isStrictCorrection,
  required final String? typedAnswer,
  required final PracticeAnswer? grade,
  required final bool isSolutionShown,
  required final bool isBusy,
  required final AppError? error,
}) extends PracticeState with PracticeActiveMappable;

@MappableClass()
class const PracticeDone() extends PracticeState with PracticeDoneMappable;

@MappableClass()
class const PracticeFailure({
  required final AppError error,
}) extends PracticeState with PracticeFailureMappable;
