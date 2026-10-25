import 'dart:math';

import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _noviceStepMinutes = 5;
const _graduationMinutes = 1440;
const _graduationLevel = 0.8;
const _minimumLevel = 0.0;
const _maximumLevel = 3.0;
const _easyLevelGain = 0.4;
const _goodLevelGain = 0.2;
const _hardLevelLoss = 0.3;
const _noviceGainFactor = 2;
const _noviceLossFactor = 0.5;
const _easyIntervalBonus = 1.3;
const _easeStep = 0.15;
const _forgotEasePenalty = 0.2;
// * the lowest ease SM-2 allows, so intervals of hard words still grow
const _minimumEase = 1.3;

@injectable
class const AnswerVocabularyUseCase(
  final VocabularyRepository _vocabularyRepository,
) {
  Future<AppResult<Vocabulary>> call({
    required Vocabulary vocabulary,
    required PracticeAnswer answer,
  }) async {
    final scheduled = _schedule(vocabulary, answer, DateTime.now().toUtc());
    if (await _vocabularyRepository.saveReview(scheduled) case Failure(:final error)) {
      return Failure(error);
    }
    return Success(scheduled);
  }

  Vocabulary _schedule(Vocabulary vocabulary, PracticeAnswer answer, DateTime now) {
    return vocabulary.isNovice
        ? _scheduleNovice(vocabulary, answer, now)
        : _scheduleLearned(vocabulary, answer, now);
  }

  Vocabulary _scheduleNovice(Vocabulary vocabulary, PracticeAnswer answer, DateTime now) {
    final level = switch (answer) {
      PracticeAnswer.forgot => _minimumLevel,
      PracticeAnswer.hard => vocabulary.level - _hardLevelLoss * _noviceLossFactor,
      PracticeAnswer.good => vocabulary.level + _goodLevelGain * _noviceGainFactor,
      PracticeAnswer.easy => vocabulary.level + _easyLevelGain * _noviceGainFactor,
    }.clamp(_minimumLevel, _maximumLevel);
    final graduates = switch (answer) {
      PracticeAnswer.good || PracticeAnswer.easy => level >= _graduationLevel,
      PracticeAnswer.forgot || PracticeAnswer.hard => false,
    };
    final intervalMinutes = graduates ? _graduationMinutes : _noviceStepMinutes;
    return vocabulary.copyWith(
      level: level,
      isNovice: !graduates,
      intervalMinutes: intervalMinutes,
      ease: switch (answer) {
        PracticeAnswer.forgot => max(vocabulary.ease - _forgotEasePenalty, _minimumEase),
        PracticeAnswer.hard || PracticeAnswer.good || PracticeAnswer.easy => vocabulary.ease,
      },
      nextReviewAt: now.add(Duration(minutes: intervalMinutes)),
    );
  }

  Vocabulary _scheduleLearned(Vocabulary vocabulary, PracticeAnswer answer, DateTime now) {
    final interval = vocabulary.intervalMinutes;
    final ease = vocabulary.ease;
    final (intervalMinutes, newEase, level) = switch (answer) {
      PracticeAnswer.forgot => (_noviceStepMinutes, ease - _forgotEasePenalty, _minimumLevel),
      PracticeAnswer.hard => (interval, ease - _easeStep, vocabulary.level - _hardLevelLoss),
      PracticeAnswer.good => ((interval * ease).round(), ease, vocabulary.level + _goodLevelGain),
      PracticeAnswer.easy => (
        (interval * ease * _easyIntervalBonus).round(),
        ease + _easeStep,
        vocabulary.level + _easyLevelGain,
      ),
    };
    return vocabulary.copyWith(
      level: level.clamp(_minimumLevel, _maximumLevel),
      isNovice: answer == PracticeAnswer.forgot,
      intervalMinutes: intervalMinutes,
      ease: max(newEase, _minimumEase),
      nextReviewAt: now.add(Duration(minutes: intervalMinutes)),
    );
  }
}
