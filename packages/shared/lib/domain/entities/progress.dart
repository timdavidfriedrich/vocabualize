import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'progress.mapper.dart';

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

extension ProgressExtensions on Progress {
  bool get isStarted => switch (stage) {
    ProgressStage.shortTerm || ProgressStage.longTerm => true,
    ProgressStage.waiting || ProgressStage.unknown => false,
  };

  bool isDueAt(DateTime moment) => isStarted && !nextReviewAt.isAfter(moment);
}
