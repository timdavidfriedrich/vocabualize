import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/error/app_result.dart';
import 'package:feature_languages/domain/use_cases/change_main_language_use_case.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

@injectable
class LanguagesBloc extends Bloc<LanguagesEvent, LanguagesState> {
  LanguagesBloc(
    this._languageRepository,
    this._vocabularyRepository,
    this._changeMainLanguage,
  ) : super(const LanguagesLoading()) {
    on<LanguagesStarted>(_onStarted);
    on<LanguagesSetupChanged>(_onSetupChanged, transformer: restartable());
    on<LanguagesMainLanguageChanged>(_onMainLanguageChanged);
  }

  final LanguageRepository _languageRepository;
  final VocabularyRepository _vocabularyRepository;
  final ChangeMainLanguageUseCase _changeMainLanguage;

  Future<void> _onStarted(LanguagesStarted event, Emitter<LanguagesState> emit) {
    return emit.forEach(
      _languageRepository.watchLanguageSetup(),
      onData: (result) => switch (result) {
        Success(data: final setup?) => _withSetup(setup),
        Success(data: null) => state,
        Failure(:final error) => LanguagesFailure(error: error),
      },
    );
  }

  LanguagesState _withSetup(LanguageSetup setup) {
    final previous = switch (state) {
      LanguagesLoaded(:final setup) => setup,
      LanguagesLoading() || LanguagesFailure() => null,
    };
    if (!_sameLanguages(previous, setup)) add(LanguagesSetupChanged(setup: setup));
    return switch (state) {
      final LanguagesLoaded loaded => loaded.copyWith(setup: setup),
      LanguagesLoading() || LanguagesFailure() => LanguagesLoaded(
        setup: setup,
        wordCounts: const {},
        isBusy: false,
        error: null,
      ),
    };
  }

  Future<void> _onSetupChanged(LanguagesSetupChanged event, Emitter<LanguagesState> emit) async {
    await Future.wait([
      for (final learned in event.setup.learned)
        emit.forEach(
          _vocabularyRepository.watchVocabularyOverview(languages: {learned.language}),
          onData: (result) => switch ((state, result)) {
            (final LanguagesLoaded loaded, Success(:final data)) => loaded.copyWith(
              wordCounts: {...loaded.wordCounts, learned.language: data.totalCount},
            ),
            (_, Success()) => state,
            (_, Failure(:final error)) => LanguagesFailure(error: error),
          },
        ),
    ]);
  }

  Future<void> _onMainLanguageChanged(
    LanguagesMainLanguageChanged event,
    Emitter<LanguagesState> emit,
  ) async {
    if (state case final LanguagesLoaded loaded when !loaded.isBusy) {
      emit(loaded.copyWith(isBusy: true, error: null));
      final result = await _changeMainLanguage(event.language);
      if (state case final LanguagesLoaded latest) {
        emit(
          latest.copyWith(
            isBusy: false,
            error: switch (result) {
              Success() => null,
              Failure(:final error) => error,
            },
          ),
        );
      }
    }
  }

  bool _sameLanguages(LanguageSetup? previous, LanguageSetup current) {
    final before = {
      for (final learned in previous?.learned ?? const <LearnedLanguage>[]) learned.language,
    };
    final after = {for (final learned in current.learned) learned.language};
    return before.length == after.length && before.containsAll(after);
  }
}
