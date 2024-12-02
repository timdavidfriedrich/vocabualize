import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

class Vocabulary {
  final String? id;
  final String source;
  final String target;
  final String sourceLanguageId;
  final String targetLanguageId;
  final List<String> tagIds;
  final VocabularyImage image;
  final Level level;
  final bool isNovice;
  final int noviceInterval;
  final int interval;
  final double ease;
  final DateTime created;
  final DateTime updated;
  final DateTime nextDate;

  bool get isValid {
    bool sourceNotEmpty = source.isNotEmpty;
    bool targetNotEmpty = target.isNotEmpty;
    bool isLevelValid = level.value >= 0 && level.value <= DueAlgorithmConstants.levelLimit;
    bool isIntervalValid = interval >= 0;
    return sourceNotEmpty && targetNotEmpty && isLevelValid && isIntervalValid;
  }

  bool get isDue {
    return nextDate.isBefore(DateTime.now());
  }

  bool get isNew {
    return created.isAfter(
      DateTime.now().subtract(const Duration(days: 7)),
    );
  }

  Vocabulary({
    this.id,
    this.source = "",
    this.target = "",
    this.sourceLanguageId = "",
    this.targetLanguageId = "",
    this.tagIds = const [],
    this.image = const FallbackImage(),
    Level? level,
    this.isNovice = true,
    this.noviceInterval = DueAlgorithmConstants.initialNoviceInterval,
    this.interval = DueAlgorithmConstants.initialInterval,
    this.ease = DueAlgorithmConstants.initialEase,
    DateTime? created,
    DateTime? updated,
    DateTime? nextDate,
  })  : level = level ?? Level(value: 0.0),
        created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now(),
        nextDate = nextDate ?? DateTime.now();

  Vocabulary copyWith({
    String? id,
    String? source,
    String? target,
    String? sourceLanguageId,
    String? targetLanguageId,
    List<String>? tagIds,
    VocabularyImage? image,
    Level? level,
    bool? isNovice,
    int? noviceInterval,
    int? interval,
    double? ease,
    DateTime? created,
    DateTime? updated,
    DateTime? nextDate,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      source: source ?? this.source,
      target: target ?? this.target,
      sourceLanguageId: sourceLanguageId ?? this.sourceLanguageId,
      targetLanguageId: targetLanguageId ?? this.targetLanguageId,
      tagIds: tagIds ?? this.tagIds,
      image: image ?? this.image,
      level: level ?? this.level,
      isNovice: isNovice ?? this.isNovice,
      noviceInterval: noviceInterval ?? this.noviceInterval,
      interval: interval ?? this.interval,
      ease: ease ?? this.ease,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      nextDate: nextDate ?? this.nextDate,
    );
  }

  Vocabulary copyWithResetProgress() {
    return copyWith(
      level: Level(value: 0.0),
      isNovice: true,
      noviceInterval: DueAlgorithmConstants.initialNoviceInterval,
      interval: DueAlgorithmConstants.initialInterval,
      ease: DueAlgorithmConstants.initialEase,
      nextDate: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Vocabulary{id: $id, source: $source, target: $target, sourceLanguageId: $sourceLanguageId, targetLanguageId: $targetLanguageId, tagIds: $tagIds, image: $image, level: $level, isNovice: $isNovice, noviceInterval: $noviceInterval, interval: $interval, ease: $ease, created: $created, updated: $updated, nextDate: $nextDate}';
  }
}
