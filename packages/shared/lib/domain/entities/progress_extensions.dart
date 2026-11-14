import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/progress.dart';

const _initialLevel = 0.0;
const _initialIntervalMinutes = 5;
const _initialEase = 2.5;

extension NewProgressExtensions on Language {
  Progress toNewProgress(ProgressStage stage, {required DateTime at}) {
    return Progress(
      language: this,
      stage: stage,
      level: _initialLevel,
      intervalMinutes: _initialIntervalMinutes,
      ease: _initialEase,
      nextReviewAt: at,
      createdAt: at,
    );
  }
}

extension ProgressExtensions on Progress {
  Progress restarted({required DateTime at}) {
    final fresh = language.toNewProgress(ProgressStage.waiting, at: at);
    return copyWith(
      stage: fresh.stage,
      level: fresh.level,
      intervalMinutes: fresh.intervalMinutes,
      ease: fresh.ease,
      nextReviewAt: fresh.nextReviewAt,
    );
  }

  bool get isStarted => switch (stage) {
    ProgressStage.shortTerm || ProgressStage.longTerm => true,
    ProgressStage.waiting || ProgressStage.unknown => false,
  };

  bool get isUnpracticed => switch (stage) {
    ProgressStage.waiting => true,
    ProgressStage.shortTerm => nextReviewAt.isAtSameMomentAs(createdAt),
    ProgressStage.longTerm || ProgressStage.unknown => false,
  };

  bool isDueAt(DateTime moment) => isStarted && !nextReviewAt.isAfter(moment);
}
