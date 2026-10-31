// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_languages/domain/use_cases/add_learned_language_use_case.dart'
    as _i1001;
import 'package:feature_languages/domain/use_cases/change_main_language_use_case.dart'
    as _i278;
import 'package:feature_languages/domain/use_cases/delete_learned_language_use_case.dart'
    as _i997;
import 'package:feature_languages/domain/use_cases/resume_learned_language_use_case.dart'
    as _i489;
import 'package:feature_languages/presentation/language_words/language_words_bloc.dart'
    as _i607;
import 'package:feature_languages/presentation/languages/languages_bloc.dart'
    as _i514;
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart'
    as _i313;
import 'package:feature_languages/presentation/onboarding/language_onboarding_bloc.dart'
    as _i660;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/language_repository.dart' as _i308;
import 'package:shared/domain/repositories/language_words_repository.dart'
    as _i1019;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;

class FeatureLanguagesPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i1001.AddLearnedLanguageUseCase>(
        () => _i1001.AddLearnedLanguageUseCase(
              gh<_i308.LanguageRepository>(),
              gh<_i1019.LanguageWordsRepository>(),
            ));
    gh.factory<_i997.DeleteLearnedLanguageUseCase>(
        () => _i997.DeleteLearnedLanguageUseCase(
              gh<_i308.LanguageRepository>(),
              gh<_i1019.LanguageWordsRepository>(),
            ));
    gh.factory<_i489.ResumeLearnedLanguageUseCase>(
        () => _i489.ResumeLearnedLanguageUseCase(
              gh<_i308.LanguageRepository>(),
              gh<_i1019.LanguageWordsRepository>(),
            ));
    gh.factory<_i278.ChangeMainLanguageUseCase>(
        () => _i278.ChangeMainLanguageUseCase(gh<_i308.LanguageRepository>()));
    gh.factory<_i660.LanguageOnboardingBloc>(
        () => _i660.LanguageOnboardingBloc(gh<_i308.LanguageRepository>()));
    gh.factory<_i313.LearnedLanguageBloc>(() => _i313.LearnedLanguageBloc(
          gh<_i308.LanguageRepository>(),
          gh<_i1019.LanguageWordsRepository>(),
          gh<_i489.ResumeLearnedLanguageUseCase>(),
          gh<_i997.DeleteLearnedLanguageUseCase>(),
        ));
    gh.factory<_i607.LanguageWordsBloc>(() => _i607.LanguageWordsBloc(
          gh<_i1019.LanguageWordsRepository>(),
          gh<_i1001.AddLearnedLanguageUseCase>(),
        ));
    gh.factory<_i514.LanguagesBloc>(() => _i514.LanguagesBloc(
          gh<_i308.LanguageRepository>(),
          gh<_i208.VocabularyRepository>(),
          gh<_i278.ChangeMainLanguageUseCase>(),
        ));
  }
}
