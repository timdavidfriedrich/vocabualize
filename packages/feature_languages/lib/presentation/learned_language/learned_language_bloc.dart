import 'package:core/error/app_result.dart';
import 'package:feature_languages/domain/use_cases/delete_learned_language_use_case.dart';
import 'package:feature_languages/domain/use_cases/resume_learned_language_use_case.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';

@injectable
class LearnedLanguageBloc extends Bloc<LearnedLanguageEvent, LearnedLanguageState> {
  LearnedLanguageBloc(
    this._languageRepository,
    this._languageWordsRepository,
    this._resumeLearnedLanguage,
    this._deleteLearnedLanguage,
  ) : super(const LearnedLanguageLoading()) {
    on<LearnedLanguageStarted>(_onStarted);
    on<LearnedLanguageAskMeInChanged>(_onAskMeInChanged);
    on<LearnedLanguageAskMeInLevelChanged>(_onAskMeInLevelChanged);
    on<LearnedLanguageNewWordsChanged>(_onNewWordsChanged);
    on<LearnedLanguagePauseRequested>(_onPauseRequested);
    on<LearnedLanguageResumeRequested>(_onResumeRequested);
    on<LearnedLanguageDeleteRequested>(_onDeleteRequested);
  }

  final LanguageRepository _languageRepository;
  final LanguageWordsRepository _languageWordsRepository;
  final ResumeLearnedLanguageUseCase _resumeLearnedLanguage;
  final DeleteLearnedLanguageUseCase _deleteLearnedLanguage;

  Future<void> _onStarted(LearnedLanguageStarted event, Emitter<LearnedLanguageState> emit) async {
    await Future.wait([
      emit.forEach(
        _languageRepository.watchLanguageSetup(),
        onData: (result) => switch (result) {
          Success(data: final setup?) => switch (setup.learnedOf(event.language)) {
            final learned? => switch (state) {
              final LearnedLanguageLoaded loaded => loaded.copyWith(
                setup: setup,
                learned: learned,
              ),
              LearnedLanguageLoading() ||
              LearnedLanguageClosed() ||
              LearnedLanguageFailure() => LearnedLanguageLoaded(
                setup: setup,
                learned: learned,
                coverage: null,
                isBusy: false,
                error: null,
              ),
            },
            null => const LearnedLanguageClosed(),
          },
          Success(data: null) => const LearnedLanguageClosed(),
          Failure(:final error) => LearnedLanguageFailure(error: error),
        },
      ),
      emit.forEach(
        _languageWordsRepository.watchLanguageCoverage(event.language),
        onData: (result) => switch ((state, result)) {
          (final LearnedLanguageLoaded loaded, Success(:final data)) => loaded.copyWith(
            coverage: data,
          ),
          (_, Success()) => state,
          (_, Failure(:final error)) => LearnedLanguageFailure(error: error),
        },
      ),
    ]);
  }

  Future<void> _onAskMeInChanged(
    LearnedLanguageAskMeInChanged event,
    Emitter<LearnedLanguageState> emit,
  ) => _save(emit, (learned) => learned.copyWith(askMeIn: event.language));

  Future<void> _onAskMeInLevelChanged(
    LearnedLanguageAskMeInLevelChanged event,
    Emitter<LearnedLanguageState> emit,
  ) => _save(emit, (learned) => learned.copyWith(askMeInFromLevel: event.level));

  Future<void> _onNewWordsChanged(
    LearnedLanguageNewWordsChanged event,
    Emitter<LearnedLanguageState> emit,
  ) => _save(emit, (learned) => learned.copyWith(newWords: event.newWords));

  Future<void> _onPauseRequested(
    LearnedLanguagePauseRequested event,
    Emitter<LearnedLanguageState> emit,
  ) => _save(emit, (learned) => learned.copyWith(isPaused: true));

  Future<void> _save(
    Emitter<LearnedLanguageState> emit,
    LearnedLanguage Function(LearnedLanguage learned) change,
  ) async {
    if (state case final LearnedLanguageLoaded loaded when !loaded.isBusy) {
      emit(loaded.copyWith(isBusy: true, error: null));
      final result = await _languageRepository.saveLearnedLanguage(change(loaded.learned));
      _finish(emit, result);
    }
  }

  Future<void> _onResumeRequested(
    LearnedLanguageResumeRequested event,
    Emitter<LearnedLanguageState> emit,
  ) async {
    if (state case final LearnedLanguageLoaded loaded when !loaded.isBusy) {
      emit(loaded.copyWith(isBusy: true, error: null));
      final result = await _resumeLearnedLanguage(loaded.learned, startsOver: event.startsOver);
      _finish(emit, result);
    }
  }

  Future<void> _onDeleteRequested(
    LearnedLanguageDeleteRequested event,
    Emitter<LearnedLanguageState> emit,
  ) async {
    if (state case final LearnedLanguageLoaded loaded when !loaded.isBusy) {
      emit(loaded.copyWith(isBusy: true, error: null));
      final result = await _deleteLearnedLanguage(loaded.learned.language);
      switch (result) {
        case Success():
          emit(const LearnedLanguageClosed());
        case Failure():
          _finish(emit, result);
      }
    }
  }

  void _finish(Emitter<LearnedLanguageState> emit, AppResult<()> result) {
    if (state case final LearnedLanguageLoaded latest) {
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
