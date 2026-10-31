import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'progress.mapper.dart';

const _initialLevel = 0.0;
const _initialIntervalMinutes = 5;
const _initialEase = 2.5;

enum ProgressStage { waiting, shortTerm, longTerm, unknown }

@MappableClass()
class const Progress({
  required final Language language,
  required final ProgressStage stage,
  required final double level,
  required final int intervalMinutes,
  required final double ease,
  required final DateTime nextReviewAt,
  required final DateTime createdAt,
}) with ProgressMappable;

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

  bool isDueAt(DateTime moment) => isStarted && !nextReviewAt.isAfter(moment);
}
