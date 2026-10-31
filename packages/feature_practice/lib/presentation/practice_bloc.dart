import 'dart:math';

import 'package:core/error/app_result.dart';
import 'package:feature_practice/domain/use_cases/answer_vocabulary_use_case.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:feature_practice/presentation/extensions/typed_answer_extensions.dart';
import 'package:feature_practice/presentation/practice_event.dart';
import 'package:feature_practice/presentation/practice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _batchSize = 20;

@injectable
class PracticeBloc extends Bloc<PracticeEvent, PracticeState> {
  PracticeBloc(
    this._vocabularyRepository,
    this._textToSpeechRepository,
    this._answerVocabulary,
    this._settingsRepository,
    this._languageRepository,
  ) : super(const PracticeLoading()) {
    on<PracticeStarted>(_onStarted);
    on<PracticeAnswerTyped>(_onAnswerTyped);
    on<PracticeSolutionRequested>(_onSolutionRequested);
    on<PracticeAnswered>(_onAnswered);
    on<PracticeSpeakRequested>(_onSpeakRequested);
  }

  final VocabularyRepository _vocabularyRepository;
  final TextToSpeechRepository _textToSpeechRepository;
  final AnswerVocabularyUseCase _answerVocabulary;
  final SettingsRepository _settingsRepository;
  final LanguageRepository _languageRepository;

  Future<void> _onStarted(PracticeStarted event, Emitter<PracticeState> emit) async {
    switch (await _languageRepository.readLanguageSetup()) {
      case Failure(:final error):
        emit(PracticeFailure(error: error));
      case Success(data: null):
        emit(const PracticeDone());
      case Success(data: final setup?):
        await _start(emit, setup, tagId: event.tagId);
    }
  }

  Future<void> _start(
    Emitter<PracticeState> emit,
    LanguageSetup setup, {
    required String? tagId,
  }) async {
    final languages = {setup.selected};
    final dueBy = DateTime.now().toUtc();
    final (count, batch, preferences) = await (
      _vocabularyRepository.countDueItems(languages: languages, dueBy: dueBy, tagId: tagId),
      _vocabularyRepository.findDueItems(
        languages: languages,
        dueBy: dueBy,
        limit: _batchSize,
        tagId: tagId,
      ),
      _settingsRepository.readPreferences(),
    ).wait;
    switch ((count, batch)) {
      case (Failure(:final error), _) || (_, Failure(:final error)):
        emit(PracticeFailure(error: error));
      case (Success(), Success(data: [])):
        emit(const PracticeDone());
      case (Success(data: final total), Success(data: final queue)):
        emit(
          PracticeActive(
            dueBy: dueBy,
            tagId: tagId,
            languages: languages,
            mainLanguage: setup.main,
            totalCount: max(total, queue.length),
            doneCount: 0,
            queue: queue,
            showsLanguages: languages.length > 1,
            isStrictCorrection: switch (preferences) {
              Success(data: Preferences(:final isStrictCorrectionEnabled)) =>
                isStrictCorrectionEnabled,
              Failure() => false,
            },
            typedAnswer: null,
            grade: null,
            isSolutionShown: false,
            isBusy: false,
            error: null,
          ),
        );
    }
  }

  void _onAnswerTyped(PracticeAnswerTyped event, Emitter<PracticeState> emit) {
    if (state case final PracticeActive active when !active.isSolutionShown) {
      final current = active.queue.first;
      emit(
        active.copyWith(
          typedAnswer: event.text,
          grade: event.text.gradeAgainst(
            current.vocabulary.textIn(current.language) ?? "",
            articles: current.language.articles,
            isStrict: active.isStrictCorrection,
          ),
          isSolutionShown: true,
        ),
      );
    }
  }

  void _onSolutionRequested(PracticeSolutionRequested event, Emitter<PracticeState> emit) {
    if (state case final PracticeActive active when !active.isSolutionShown) {
      emit(active.copyWith(isSolutionShown: true));
    }
  }

  Future<void> _onAnswered(PracticeAnswered event, Emitter<PracticeState> emit) async {
    final active = state;
    if (active is! PracticeActive || active.isBusy || !active.grade.allows(event.answer)) return;
    final busy = active.copyWith(isBusy: true, error: null);
    emit(busy);
    final result = await _answerVocabulary(item: active.queue.first, answer: event.answer);
    if (result case Failure(:final error)) {
      emit(busy.copyWith(isBusy: false, error: error));
      return;
    }
    final remaining = active.queue.skip(1).toList();
    final next = remaining.isNotEmpty
        ? Success(remaining)
        : await _vocabularyRepository.findDueItems(
            languages: active.languages,
            dueBy: active.dueBy,
            limit: _batchSize,
            tagId: active.tagId,
          );
    switch (next) {
      case Failure(:final error):
        emit(PracticeFailure(error: error));
      case Success(data: []):
        emit(const PracticeDone());
      case Success(data: final queue):
        emit(
          busy.copyWith(
            doneCount: active.doneCount + 1,
            totalCount: max(active.totalCount, active.doneCount + 1 + queue.length),
            queue: queue,
            typedAnswer: null,
            grade: null,
            isSolutionShown: false,
            isBusy: false,
          ),
        );
    }
  }

  Future<void> _onSpeakRequested(PracticeSpeakRequested event, Emitter<PracticeState> emit) async {
    if (state case final PracticeActive active) {
      final current = active.queue.first;
      final text = current.vocabulary.textIn(current.language);
      if (text == null) return;
      final result = await _textToSpeechRepository.speak(text: text, language: current.language);
      if (result case Failure(:final error)) {
        if (state case final PracticeActive latest) emit(latest.copyWith(error: error));
      }
    }
  }
}
