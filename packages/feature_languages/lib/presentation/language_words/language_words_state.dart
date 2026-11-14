import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_words_change.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'language_words_state.mapper.dart';

@MappableEnum()
enum LanguageWordsOption { all, choose, none }

@MappableClass()
sealed class LanguageWordsState with LanguageWordsStateMappable {
  const LanguageWordsState();
}

@MappableClass()
class const LanguageWordsLoading() extends LanguageWordsState with LanguageWordsLoadingMappable;

@MappableClass()
class const LanguageWordsEditing({
  required final Language language,
  required final bool isAdding,
  required final LanguageCoverage coverage,
  required final Map<String, VocabularyImage> images,
  required final LanguageWordsOption option,
  required final Map<String, bool?> initialSelection,
  required final Map<String, bool?> selection,
  required final bool? initialUntagged,
  required final bool? untagged,
  required final LanguageWordsPreview? preview,
  required final bool isSaving,
  required final AppError? error,
}) extends LanguageWordsState with LanguageWordsEditingMappable;

@MappableClass()
class const LanguageWordsSaved() extends LanguageWordsState with LanguageWordsSavedMappable;

@MappableClass()
class const LanguageWordsFailure({
  required final AppError error,
}) extends LanguageWordsState with LanguageWordsFailureMappable;
