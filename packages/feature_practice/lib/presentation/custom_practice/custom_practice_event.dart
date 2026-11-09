import 'package:shared/domain/entities/language.dart';

sealed class CustomPracticeEvent {
  const CustomPracticeEvent();
}

class const CustomPracticeStarted({
  required final String? tagId,
}) extends CustomPracticeEvent;

class const CustomPracticeLanguageToggled({
  required final Language language,
}) extends CustomPracticeEvent;

class const CustomPracticeAllWordsToggled({
  required final Language language,
}) extends CustomPracticeEvent;

class const CustomPracticeReviewWordsChanged({
  required final Language language,
  required final int count,
}) extends CustomPracticeEvent;

class const CustomPracticeNewWordsChanged({
  required final Language language,
  required final int count,
}) extends CustomPracticeEvent;

class const CustomPracticeCollectionsChanged({
  required final Set<String> tagIds,
}) extends CustomPracticeEvent;

class const CustomPracticeCountsRequested() extends CustomPracticeEvent;

class const CustomPracticePreviewRequested() extends CustomPracticeEvent;

class const CustomPracticeStartRequested() extends CustomPracticeEvent;
