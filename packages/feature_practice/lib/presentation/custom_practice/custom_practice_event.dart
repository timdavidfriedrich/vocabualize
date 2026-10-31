import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_session.dart';

sealed class CustomPracticeEvent {
  const CustomPracticeEvent();
}

class const CustomPracticeStarted({
  required final String? tagId,
}) extends CustomPracticeEvent;

class const CustomPracticeLanguageToggled({
  required final Language language,
}) extends CustomPracticeEvent;

class const CustomPracticeAllLanguagesSelected() extends CustomPracticeEvent;

class const CustomPracticeCollectionsModeChanged({
  required final bool isChoosing,
}) extends CustomPracticeEvent;

class const CustomPracticeCollectionToggled({
  required final String tagId,
}) extends CustomPracticeEvent;

class const CustomPracticeWordsChanged({
  required final PracticeWords words,
}) extends CustomPracticeEvent;

class const CustomPracticeNewWordsChanged({
  required final PracticeNewWords newWords,
}) extends CustomPracticeEvent;

class const CustomPracticeCountRequested() extends CustomPracticeEvent;

class const CustomPracticeStartRequested() extends CustomPracticeEvent;
