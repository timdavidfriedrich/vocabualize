import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'language_onboarding_state.mapper.dart';

@MappableClass()
sealed class LanguageOnboardingState with LanguageOnboardingStateMappable {
  const LanguageOnboardingState();
}

@MappableClass()
class const LanguageOnboardingLoading() extends LanguageOnboardingState
    with LanguageOnboardingLoadingMappable;

@MappableClass()
class const LanguageOnboardingEditing({
  required final Language main,
  required final List<Language> learned,
  required final bool isSaving,
  required final AppError? error,
}) extends LanguageOnboardingState with LanguageOnboardingEditingMappable;

@MappableClass()
class const LanguageOnboardingSaved() extends LanguageOnboardingState
    with LanguageOnboardingSavedMappable;
