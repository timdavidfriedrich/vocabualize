// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pocketbase/pocketbase.dart';

import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/src/common/data/utils/date_parser.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

class Vocabulary {
  final String? id;
  final String source;
  final String target;
  final Language sourceLanguage;
  final Language targetLanguage;
  final List<Tag> tags;
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

  Vocabulary({
    this.id,
    this.source = "",
    this.target = "",
    sourceLanguage,
    targetLanguage,
    this.tags = const [],
    this.image = const FallbackImage(),
    this.level = const Level(),
    this.isNovice = true,
    this.noviceInterval = DueAlgorithmConstants.initialNoviceInterval,
    this.interval = DueAlgorithmConstants.initialInterval,
    this.ease = DueAlgorithmConstants.initialEase,
    created,
    updated,
    nextDate,
  })  : sourceLanguage = sourceLanguage ?? Language.defaultSource(),
        targetLanguage = targetLanguage ?? Language.defaultTarget(),
        created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now(),
        nextDate = nextDate ?? DateTime.now();

  // TODO: Remove Vocabulary.fromRecord() => use mappers if not already done
  Vocabulary.fromRecord(
    RecordModel recordModel, {
    List<Tag>? tags,
    List<Language>? languages,
  })  : id = recordModel.id,
        source = recordModel.data['source'],
        target = recordModel.data['target'],
        // TODO: Replace with usecase??? or maybe just do this when creating the vocabulary
        sourceLanguage = languages?.where((element) => element.id == recordModel.data['sourceLanguage']).first ?? Language.defaultSource(),
        targetLanguage = languages?.where((element) => element.id == recordModel.data['targetLanguage']).first ?? Language.defaultTarget(),
        tags = tags ?? [],
        // TODO: Implement image
        image = const FallbackImage(), //VocabularyImage.fromJson(recordModel.data['image']),
        level = Level.withValue(value: recordModel.data['levelValue'] ?? 0.0),
        isNovice = recordModel.data['isNovice'] ?? false,
        noviceInterval = recordModel.data['noviceInterval'] ?? DueAlgorithmConstants.initialNoviceInterval,
        interval = recordModel.data['interval'] ?? DueAlgorithmConstants.initialInterval,
        ease = recordModel.data['ease'] ?? DueAlgorithmConstants.initialEase,
        nextDate = DateParser.parseOrNull(recordModel.data['nextDate']) ?? DateTime.now(),
        created = DateParser.parseOrNull(recordModel.data['created']) ?? DateTime.now(),
        updated = DateParser.parseOrNull(recordModel.data['updated']) ?? DateTime.now();

  Vocabulary copyWith({
    String? id,
    String? source,
    String? target,
    Language? sourceLanguage,
    Language? targetLanguage,
    List<Tag>? tags,
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
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      tags: tags ?? this.tags,
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
      level: const Level(),
      isNovice: true,
      noviceInterval: DueAlgorithmConstants.initialNoviceInterval,
      interval: DueAlgorithmConstants.initialInterval,
      ease: DueAlgorithmConstants.initialEase,
      nextDate: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Vocabulary{id: $id, source: $source, target: $target, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, tags: $tags, image: $image, level: $level, isNovice: $isNovice, noviceInterval: $noviceInterval, interval: $interval, ease: $ease, created: $created, updated: $updated, nextDate: $nextDate}';
  }
}
