import 'dart:math';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/progress.dart';
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
  Future<AppResult<Progress>> call({
    required PracticeItem item,
    required PracticeAnswer answer,
  }) async {
    final progress = item.vocabulary.progress[item.language];
    if (progress == null) return const Failure(NotFoundError());
    final now = DateTime.now().toUtc();
    if (!progress.isDueAt(now)) {
      final recorded = await _vocabularyRepository.recordPractice();
      if (recorded case Failure(:final error)) return Failure(error);
      return Success(progress);
    }
    final scheduled = _schedule(progress, answer, now);
    final saved = await _vocabularyRepository.saveReview(
      vocabularyId: item.vocabulary.id,
      progress: scheduled,
    );
    if (saved case Failure(:final error)) return Failure(error);
    return Success(scheduled);
  }

  Progress _schedule(Progress progress, PracticeAnswer answer, DateTime now) {
    return switch (progress.stage) {
      ProgressStage.longTerm => _scheduleLongTerm(progress, answer, now),
      ProgressStage.shortTerm ||
      ProgressStage.waiting ||
      ProgressStage.unknown => _scheduleShortTerm(progress, answer, now),
    };
  }

  Progress _scheduleShortTerm(Progress progress, PracticeAnswer answer, DateTime now) {
    final level = switch (answer) {
      PracticeAnswer.forgot => _minimumLevel,
      PracticeAnswer.hard => progress.level - _hardLevelLoss * _noviceLossFactor,
      PracticeAnswer.good => progress.level + _goodLevelGain * _noviceGainFactor,
      PracticeAnswer.easy => progress.level + _easyLevelGain * _noviceGainFactor,
    }.clamp(_minimumLevel, _maximumLevel);
    final graduates = switch (answer) {
      PracticeAnswer.good || PracticeAnswer.easy => level >= _graduationLevel,
      PracticeAnswer.forgot || PracticeAnswer.hard => false,
    };
    final intervalMinutes = graduates ? _graduationMinutes : _noviceStepMinutes;
    return progress.copyWith(
      stage: graduates ? ProgressStage.longTerm : ProgressStage.shortTerm,
      level: level,
      intervalMinutes: intervalMinutes,
      ease: switch (answer) {
        PracticeAnswer.forgot => max(progress.ease - _forgotEasePenalty, _minimumEase),
        PracticeAnswer.hard || PracticeAnswer.good || PracticeAnswer.easy => progress.ease,
      },
      nextReviewAt: now.add(Duration(minutes: intervalMinutes)),
    );
  }

  Progress _scheduleLongTerm(Progress progress, PracticeAnswer answer, DateTime now) {
    final interval = progress.intervalMinutes;
    final ease = progress.ease;
    final (intervalMinutes, newEase, level) = switch (answer) {
      PracticeAnswer.forgot => (_noviceStepMinutes, ease - _forgotEasePenalty, _minimumLevel),
      PracticeAnswer.hard => (interval, ease - _easeStep, progress.level - _hardLevelLoss),
      PracticeAnswer.good => ((interval * ease).round(), ease, progress.level + _goodLevelGain),
      PracticeAnswer.easy => (
        (interval * ease * _easyIntervalBonus).round(),
        ease + _easeStep,
        progress.level + _easyLevelGain,
      ),
    };
    return progress.copyWith(
      stage: answer == PracticeAnswer.forgot ? ProgressStage.shortTerm : ProgressStage.longTerm,
      level: level.clamp(_minimumLevel, _maximumLevel),
      intervalMinutes: intervalMinutes,
      ease: max(newEase, _minimumEase),
      nextReviewAt: now.add(Duration(minutes: intervalMinutes)),
    );
  }
}
