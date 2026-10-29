// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:feature_practice/domain/use_cases/answer_vocabulary_use_case.dart'
    as _i486;
import 'package:feature_practice/presentation/practice_bloc.dart' as _i214;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared/domain/repositories/settings_repository.dart' as _i0;
import 'package:shared/domain/repositories/text_to_speech_repository.dart'
    as _i839;
import 'package:shared/domain/repositories/vocabulary_repository.dart' as _i208;

class FeaturePracticePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i486.AnswerVocabularyUseCase>(
        () => _i486.AnswerVocabularyUseCase(gh<_i208.VocabularyRepository>()));
    gh.factory<_i214.PracticeBloc>(() => _i214.PracticeBloc(
          gh<_i208.VocabularyRepository>(),
          gh<_i839.TextToSpeechRepository>(),
          gh<_i486.AnswerVocabularyUseCase>(),
          gh<_i0.SettingsRepository>(),
        ));
  }
}
