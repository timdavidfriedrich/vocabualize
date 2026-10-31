import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/domain/entities/practice_session.dart';

part 'practice_state.mapper.dart';

@MappableClass()
sealed class PracticeState with PracticeStateMappable {
  const PracticeState();
}

@MappableClass()
class const PracticeLoading() extends PracticeState with PracticeLoadingMappable;

@MappableClass()
class const PracticeActive({
  required final String? tagId,
  required final bool isCustom,
  required final LanguageSetup setup,
  required final Set<Language> languages,
  required final DateTime dueBy,
  required final int totalCount,
  required final int doneCount,
  required final List<PracticeCard> queue,
  required final List<PracticeCard> newCards,
  required final List<PracticeItemKey> pendingKeys,
  required final bool isStrictCorrection,
  required final String? typedAnswer,
  required final PracticeAnswer? grade,
  required final bool isSolutionShown,
  required final bool isPromptRevealed,
  required final bool isBusy,
  required final AppError? error,
}) extends PracticeState with PracticeActiveMappable;

@MappableClass()
class const PracticeDone() extends PracticeState with PracticeDoneMappable;

@MappableClass()
class const PracticeFailure({
  required final AppError error,
}) extends PracticeState with PracticeFailureMappable;

extension PracticeActiveExtensions on PracticeActive {
  PracticeCard get current => queue.first;

  bool showsLanguagesFor(PracticeCard card) => languages.length > 1 || card.prompt != setup.main;
}
