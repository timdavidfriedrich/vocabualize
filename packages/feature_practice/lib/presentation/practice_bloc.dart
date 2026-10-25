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
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _batchSize = 20;

@injectable
class PracticeBloc extends Bloc<PracticeEvent, PracticeState> {
  PracticeBloc(
    this._vocabularyRepository,
    this._textToSpeechRepository,
    this._answerVocabulary,
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

  Future<void> _onStarted(PracticeStarted event, Emitter<PracticeState> emit) async {
    final dueBy = DateTime.now().toUtc();
    final (count, batch) = await (
      _vocabularyRepository.countDueVocabularies(dueBy),
      _vocabularyRepository.findDueVocabularies(dueBy: dueBy, limit: _batchSize),
    ).wait;
    switch ((count, batch)) {
      case (Failure(:final error), _) || (_, Failure(:final error)):
        emit(PracticeFailure(error: error));
      case (Success(), Success(data: [])):
        emit(const PracticeDone());
      case (Success(data: final total), Success(data: final queue)):
        final first = queue.first;
        final showsLanguages = await _vocabularyRepository.hasDueVocabulariesOutside(
          dueBy: dueBy,
          languages: LanguagePair(source: first.sourceLanguage, target: first.targetLanguage),
        );
        emit(
          PracticeActive(
            dueBy: dueBy,
            totalCount: max(total, queue.length),
            doneCount: 0,
            queue: queue,
            showsLanguages: switch (showsLanguages) {
              Success(:final data) => data,
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
            current.target,
            articles: current.targetLanguage.articles,
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
    final result = await _answerVocabulary(vocabulary: active.queue.first, answer: event.answer);
    if (result case Failure(:final error)) {
      emit(busy.copyWith(isBusy: false, error: error));
      return;
    }
    final remaining = active.queue.skip(1).toList();
    final next = remaining.isNotEmpty
        ? Success(remaining)
        : await _vocabularyRepository.findDueVocabularies(dueBy: active.dueBy, limit: _batchSize);
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
      final result = await _textToSpeechRepository.speak(
        text: current.target,
        language: current.targetLanguage,
      );
      if (result case Failure(:final error)) {
        if (state case final PracticeActive latest) emit(latest.copyWith(error: error));
      }
    }
  }
}
