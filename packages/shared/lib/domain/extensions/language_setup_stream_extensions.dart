import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';

extension LanguageSetupStreamExtensions on Stream<AppResult<LanguageSetup?>> {
  Stream<AppResult<Set<Language>>> toDistinctLanguages(
    Iterable<LearnedLanguage> Function(LanguageSetup setup) select,
  ) {
    return map<AppResult<Set<Language>>>(
      (result) => switch (result) {
        Success(:final data) => Success({
          if (data != null)
            for (final learnedLanguage in select(data)) learnedLanguage.language,
        }),
        Failure(:final error) => Failure(error),
      },
    ).distinct(_isSameSelection);
  }
}

bool _isSameSelection(AppResult<Set<Language>> previous, AppResult<Set<Language>> next) {
  return switch ((previous, next)) {
    (Success(data: final previous), Success(data: final next)) =>
      previous.length == next.length && previous.containsAll(next),
    (_, _) => false,
  };
}
