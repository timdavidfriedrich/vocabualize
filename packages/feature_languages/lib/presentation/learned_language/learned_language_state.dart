import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_setup.dart';

part 'learned_language_state.mapper.dart';

@MappableClass()
sealed class LearnedLanguageState with LearnedLanguageStateMappable {
  const LearnedLanguageState();
}

@MappableClass()
class const LearnedLanguageLoading()
    extends LearnedLanguageState
    with LearnedLanguageLoadingMappable;

@MappableClass()
class const LearnedLanguageLoaded({
  required final LanguageSetup setup,
  required final LearnedLanguage learned,
  required final LanguageCoverage? coverage,
  required final bool isBusy,
  required final AppError? error,
}) extends LearnedLanguageState with LearnedLanguageLoadedMappable;

@MappableClass()
class const LearnedLanguageClosed() extends LearnedLanguageState with LearnedLanguageClosedMappable;

@MappableClass()
class const LearnedLanguageFailure({
  required final AppError error,
}) extends LearnedLanguageState with LearnedLanguageFailureMappable;
