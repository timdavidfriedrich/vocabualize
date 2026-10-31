import 'package:shared/domain/entities/practice_answer.dart';

sealed class PracticeEvent {
  const PracticeEvent();
}

class const PracticeStarted({
  required final String? tagId,
}) extends PracticeEvent;

class const PracticeCustomStarted() extends PracticeEvent;

class const PracticeAnswerTyped({
  required final String text,
}) extends PracticeEvent;

class const PracticeSolutionRequested() extends PracticeEvent;

class const PracticeAnswered({
  required final PracticeAnswer answer,
}) extends PracticeEvent;

class const PracticeSpeakRequested() extends PracticeEvent;

class const PracticeIntroConfirmed() extends PracticeEvent;

class const PracticeIntroSkipped() extends PracticeEvent;

class const PracticePromptRevealed() extends PracticeEvent;

class const PracticeCardEdited() extends PracticeEvent;
