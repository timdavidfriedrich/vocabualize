import 'dart:math';

import 'package:core/error/app_result.dart';
import 'package:feature_practice/domain/use_cases/answer_vocabulary_use_case.dart';
import 'package:feature_practice/domain/use_cases/introduce_vocabulary_use_case.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:feature_practice/presentation/extensions/typed_answer_extensions.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/practice/practice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/repositories/custom_practice_repository.dart';
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
    this._introduceVocabulary,
    this._settingsRepository,
    this._languageRepository,
    this._customPracticeRepository,
  ) : super(const PracticeLoading()) {
    on<PracticeStarted>(_onStarted);
    on<PracticeCustomStarted>(_onCustomStarted);
    on<PracticeAnswerTyped>(_onAnswerTyped);
    on<PracticeSolutionRequested>(_onSolutionRequested);
    on<PracticeAnswered>(_onAnswered);
    on<PracticeSpeakRequested>(_onSpeakRequested);
    on<PracticeIntroConfirmed>(_onIntroConfirmed);
    on<PracticeIntroSkipped>(_onIntroSkipped);
    on<PracticePromptRevealed>(_onPromptRevealed);
    on<PracticeCardEdited>(_onCardEdited);
  }

  final VocabularyRepository _vocabularyRepository;
  final TextToSpeechRepository _textToSpeechRepository;
  final AnswerVocabularyUseCase _answerVocabulary;
  final IntroduceVocabularyUseCase _introduceVocabulary;
  final SettingsRepository _settingsRepository;
  final LanguageRepository _languageRepository;
  final CustomPracticeRepository _customPracticeRepository;

  Future<void> _onStarted(PracticeStarted event, Emitter<PracticeState> emit) async {
    final setup = await _readSetup(emit);
    if (setup == null) return;
    final language = setup.selected;
    final tagIds = {?event.tagId};
    final dueBy = DateTime.now().toUtc();
    final (count, batch, waiting) = await (
      _vocabularyRepository.countDueItems(languages: {language}, dueBy: dueBy, tagIds: tagIds),
      _vocabularyRepository.findDueItems(
        languages: {language},
        dueBy: dueBy,
        limit: _batchSize,
        tagIds: tagIds,
      ),
      _vocabularyRepository.findWaitingItems(
        language: language,
        limit: switch (setup.learnedOf(language)?.newWords) {
          NewWordsUpTo(:final count) => count,
          AllNewWords() || null => null,
        },
        tagIds: tagIds,
      ),
    ).wait;
    switch ((count, batch, waiting)) {
      case (Failure(:final error), _, _) ||
          (_, Failure(:final error), _) ||
          (_, _, Failure(:final error)):
        emit(PracticeFailure(error: error));
      case (Success(data: final total), Success(data: final due), Success(data: final fresh)):
        final queue = _cardsOf(due, setup);
        final newCards = _cardsOf(fresh, setup);
        await _emitStart(
          emit,
          PracticeActive(
            tagId: event.tagId,
            isCustom: false,
            setup: setup,
            languages: {language},
            dueBy: dueBy,
            totalCount: max(total, queue.length) + newCards.length,
            doneCount: 0,
            queue: queue.isEmpty ? newCards : queue,
            newCards: queue.isEmpty ? const [] : newCards,
            pendingKeys: const [],
            isStrictCorrection: await _isStrictCorrection(),
            typedAnswer: null,
            grade: null,
            isSolutionShown: false,
            isPromptRevealed: false,
            isBusy: false,
            error: null,
          ),
        );
    }
  }

  Future<void> _onCustomStarted(PracticeCustomStarted event, Emitter<PracticeState> emit) async {
    final setup = await _readSetup(emit);
    if (setup == null) return;
    switch (await _customPracticeRepository.readSession()) {
      case Failure(:final error):
        emit(PracticeFailure(error: error));
      case Success(data: null):
        emit(const PracticeDone());
      case Success(data: final session?):
        final start = PracticeActive(
          tagId: null,
          isCustom: true,
          setup: setup,
          languages: session.filter.languages,
          dueBy: DateTime.now().toUtc(),
          totalCount: session.items.length,
          doneCount: session.doneCount,
          queue: const [],
          newCards: const [],
          pendingKeys: session.items.skip(session.doneCount).toList(),
          isStrictCorrection: await _isStrictCorrection(),
          typedAnswer: null,
          grade: null,
          isSolutionShown: false,
          isPromptRevealed: false,
          isBusy: false,
          error: null,
        );
        await _emitStart(emit, await _filled(start));
    }
  }

  void _onAnswerTyped(PracticeAnswerTyped event, Emitter<PracticeState> emit) {
    if (state case final PracticeActive active when !active.isSolutionShown) {
      final item = active.current.item;
      emit(
        active.copyWith(
          typedAnswer: event.text,
          grade: event.text.gradeAgainst(
            item.vocabulary.textIn(item.language) ?? "",
            articles: item.language.articles,
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
    await _step(
      emit,
      active,
      () => _answerVocabulary(item: active.current.item, answer: event.answer),
    );
  }

  Future<void> _onIntroConfirmed(PracticeIntroConfirmed event, Emitter<PracticeState> emit) async {
    if (state case final PracticeActive active when !active.isBusy && active.current.isIntro) {
      await _step(emit, active, () => _introduceVocabulary(active.current.item));
    }
  }

  Future<void> _onIntroSkipped(PracticeIntroSkipped event, Emitter<PracticeState> emit) async {
    if (state case final PracticeActive active when !active.isBusy && active.current.isIntro) {
      final item = active.current.item;
      await _step(
        emit,
        active,
        () => _vocabularyRepository.removeFromLanguage(
          vocabularyId: item.vocabulary.id,
          language: item.language,
        ),
      );
    }
  }

  void _onPromptRevealed(PracticePromptRevealed event, Emitter<PracticeState> emit) {
    if (state case final PracticeActive active) emit(active.copyWith(isPromptRevealed: true));
  }

  Future<void> _onCardEdited(PracticeCardEdited event, Emitter<PracticeState> emit) async {
    if (state case final PracticeActive active) {
      final item = active.current.item;
      final result = await _vocabularyRepository.findItems([
        PracticeItemKey(vocabularyId: item.vocabulary.id, language: item.language),
      ]);
      if (state case final PracticeActive latest) {
        final cards = switch (result) {
          Success(:final data) => _cardsOf(data, latest.setup),
          Failure() => const <PracticeCard>[],
        };
        emit(
          switch (cards) {
            [final card, ...] => latest.copyWith(queue: [card, ...latest.queue.skip(1)]),
            _ => await _advanced(latest),
          },
        );
      }
    }
  }

  Future<void> _onSpeakRequested(PracticeSpeakRequested event, Emitter<PracticeState> emit) async {
    if (state case final PracticeActive active) {
      final item = active.current.item;
      final text = item.vocabulary.textIn(item.language);
      if (text == null) return;
      final result = await _textToSpeechRepository.speak(text: text, language: item.language);
      if (result case Failure(:final error)) {
        if (state case final PracticeActive latest) emit(latest.copyWith(error: error));
      }
    }
  }

  Future<void> _step(
    Emitter<PracticeState> emit,
    PracticeActive active,
    Future<AppResult<Object?>> Function() action,
  ) async {
    final busy = active.copyWith(isBusy: true, error: null);
    emit(busy);
    if (await action() case Failure(:final error)) {
      emit(busy.copyWith(isBusy: false, error: error));
      return;
    }
    emit(await _advanced(busy));
  }

  Future<PracticeState> _advanced(PracticeActive active) async {
    final next = await _filled(
      active.copyWith(
        doneCount: active.doneCount + 1,
        queue: active.queue.skip(1).toList(),
        typedAnswer: null,
        grade: null,
        isSolutionShown: false,
        isPromptRevealed: false,
        isBusy: false,
      ),
    );
    if (next.isCustom) await _saveProgress(next);
    return next.queue.isEmpty ? const PracticeDone() : next;
  }

  Future<PracticeActive> _filled(PracticeActive active) async {
    var current = active;
    while (current.queue.isEmpty) {
      if (current.isCustom) {
        if (current.pendingKeys.isEmpty) return current;
        final keys = current.pendingKeys.take(_batchSize).toList();
        final result = await _vocabularyRepository.findItems(keys);
        final cards = switch (result) {
          Success(:final data) => _cardsOf(data, current.setup),
          Failure() => const <PracticeCard>[],
        };
        current = current.copyWith(
          queue: cards,
          pendingKeys: current.pendingKeys.skip(keys.length).toList(),
          doneCount: current.doneCount + keys.length - cards.length,
        );
      } else {
        final result = await _vocabularyRepository.findDueItems(
          languages: current.languages,
          dueBy: current.dueBy,
          limit: _batchSize,
          tagIds: {?current.tagId},
        );
        final cards = switch (result) {
          Success(:final data) => _cardsOf(data, current.setup),
          Failure() => const <PracticeCard>[],
        };
        current = cards.isNotEmpty
            ? current.copyWith(queue: cards)
            : current.copyWith(queue: current.newCards, newCards: const []);
        if (current.queue.isEmpty) return current;
      }
    }
    return current;
  }

  Future<void> _saveProgress(PracticeActive active) async {
    switch (await _customPracticeRepository.readSession()) {
      case Success(data: _?) when active.queue.isEmpty && active.pendingKeys.isEmpty:
        await _customPracticeRepository.endSession();
      case Success(data: final session?):
        await _customPracticeRepository.saveSession(session.copyWith(doneCount: active.doneCount));
      case Success() || Failure():
        break;
    }
  }

  Future<void> _emitStart(Emitter<PracticeState> emit, PracticeActive active) async {
    if (active.queue.isEmpty) {
      if (active.isCustom) await _customPracticeRepository.endSession();
      emit(const PracticeDone());
    } else {
      emit(active);
    }
  }

  List<PracticeCard> _cardsOf(List<PracticeItem> items, LanguageSetup setup) {
    return [
      for (final item in items)
        if ((setup.promptFor(item.vocabulary, item.language), item.vocabulary.textIn(item.language))
            case (final prompt?, _?))
          PracticeCard(
            item: item,
            prompt: prompt,
            isIntro: item.vocabulary.progress[item.language]?.stage == ProgressStage.waiting,
          ),
    ];
  }

  Future<LanguageSetup?> _readSetup(Emitter<PracticeState> emit) async {
    switch (await _languageRepository.readLanguageSetup()) {
      case Success(data: final setup?):
        return setup;
      case Success():
        emit(const PracticeDone());
      case Failure(:final error):
        emit(PracticeFailure(error: error));
    }
    return null;
  }

  Future<bool> _isStrictCorrection() async {
    return switch (await _settingsRepository.readPreferences()) {
      Success(data: Preferences(:final isStrictCorrectionEnabled)) => isStrictCorrectionEnabled,
      Failure() => false,
    };
  }
}
