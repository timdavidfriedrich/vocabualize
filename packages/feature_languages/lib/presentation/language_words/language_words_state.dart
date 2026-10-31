import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_words_change.dart';

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
  required final LanguageWordsOption option,
  required final Map<String, bool?> initialSelection,
  required final Map<String, bool?> selection,
  required final bool? initialUntagged,
  required final bool? untagged,
  required final NewWordLimit newWords,
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

extension LanguageWordsEditingExtensions on LanguageWordsEditing {
  LanguageWordsChange get change => LanguageWordsChange(
    addsAll: false,
    addedTagIds: {
      for (final MapEntry(key: tagId, value: isSelected) in selection.entries)
        if (isSelected == true && initialSelection[tagId] != true) tagId,
    },
    removedTagIds: {
      for (final MapEntry(key: tagId, value: isSelected) in selection.entries)
        if (isSelected == false && initialSelection[tagId] != false) tagId,
    },
    addsUntagged: untagged == true && initialUntagged != true,
    removesUntagged: untagged == false && initialUntagged != false,
  );

  bool get hasChanges {
    final change = this.change;
    return change.addedTagIds.isNotEmpty ||
        change.removedTagIds.isNotEmpty ||
        change.addsUntagged ||
        change.removesUntagged;
  }
}
