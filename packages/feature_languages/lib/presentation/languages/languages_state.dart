import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';

part 'languages_state.mapper.dart';

@MappableClass()
sealed class LanguagesState with LanguagesStateMappable {
  const LanguagesState();
}

@MappableClass()
class const LanguagesLoading() extends LanguagesState with LanguagesLoadingMappable;

@MappableClass()
class const LanguagesLoaded({
  required final LanguageSetup setup,
  required final Map<Language, int> wordCounts,
  required final bool isBusy,
  required final AppError? error,
}) extends LanguagesState with LanguagesLoadedMappable;

@MappableClass()
class const LanguagesFailure({
  required final AppError error,
}) extends LanguagesState with LanguagesFailureMappable;
