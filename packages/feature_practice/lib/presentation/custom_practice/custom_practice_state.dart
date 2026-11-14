import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'custom_practice_state.mapper.dart';

@MappableClass()
sealed class CustomPracticeState with CustomPracticeStateMappable {
  const CustomPracticeState();
}

@MappableClass()
class const CustomPracticeLoading() extends CustomPracticeState with CustomPracticeLoadingMappable;

@MappableClass()
class const CustomPracticeEditing({
  required final LanguageSetup setup,
  required final List<Tag> tags,
  required final Map<String, VocabularyImage> collectionImages,
  required final Map<String, int> collectionCounts,
  required final Set<String> tagIds,
  required final Set<Language> enabledLanguages,
  required final Set<Language> allWordsLanguages,
  required final Map<Language, int> reviewWordCounts,
  required final Map<Language, int> newWordCounts,
  required final Map<Language, CustomPracticeCounts>? counts,
  required final List<VocabularyImage> previewImages,
  required final bool hasUnfinishedSession,
  required final bool isStarting,
  required final AppError? error,
}) extends CustomPracticeState with CustomPracticeEditingMappable;

@MappableClass()
class const CustomPracticeLaunched()
    extends CustomPracticeState
    with CustomPracticeLaunchedMappable;

@MappableClass()
class const CustomPracticeFailure({
  required final AppError error,
}) extends CustomPracticeState with CustomPracticeFailureMappable;
