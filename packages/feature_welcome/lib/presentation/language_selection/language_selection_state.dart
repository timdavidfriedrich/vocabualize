import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language_pair.dart';

part 'language_selection_state.mapper.dart';

@MappableClass()
sealed class LanguageSelectionState with LanguageSelectionStateMappable {
  const LanguageSelectionState();
}

@MappableClass()
class const LanguageSelectionLoading() extends LanguageSelectionState
    with LanguageSelectionLoadingMappable;

@MappableClass()
class const LanguageSelectionEditing({
  required final LanguagePair pair,
  required final bool isSaving,
  required final AppError? error,
}) extends LanguageSelectionState with LanguageSelectionEditingMappable;

@MappableClass()
class const LanguageSelectionSaved() extends LanguageSelectionState
    with LanguageSelectionSavedMappable;
