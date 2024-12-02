import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';

class RdbVocabulary {
  final String? id;
  final String user;
  final String source;
  final String target;
  final String sourceLanguageId;
  final String targetLanguageId;
  final List<String> tagIds;
  final RdbCustomImage? customImage;
  final RdbStockImage? stockImage;
  final double levelValue;
  final bool isNovice;
  final int interval;
  final double ease;
  final String nextDate;
  final String created;
  final String updated;

  const RdbVocabulary({
    this.id,
    this.user = "",
    this.source = "",
    this.target = "",
    this.sourceLanguageId = "",
    this.targetLanguageId = "",
    this.tagIds = const [],
    this.customImage,
    this.stockImage,
    this.levelValue = 0.0,
    this.isNovice = true,
    this.interval = DueAlgorithmConstants.initialInterval,
    this.ease = DueAlgorithmConstants.initialEase,
    this.nextDate = "",
    this.created = "",
    this.updated = "",
  });

  RdbVocabulary copyWith({
    String? id,
    String? user,
    String? source,
    String? target,
    String? sourceLanguageId,
    String? targetLanguageId,
    List<String>? tagIds,
    RdbCustomImage? customImage,
    RdbStockImage? stockImage,
    double? levelValue,
    bool? isNovice,
    int? interval,
    double? ease,
    String? nextDate,
    String? created,
    String? updated,
  }) {
    return RdbVocabulary(
      id: id ?? this.id,
      user: user ?? this.user,
      source: source ?? this.source,
      target: target ?? this.target,
      sourceLanguageId: sourceLanguageId ?? this.sourceLanguageId,
      targetLanguageId: targetLanguageId ?? this.targetLanguageId,
      tagIds: tagIds ?? this.tagIds,
      customImage: customImage ?? this.customImage,
      stockImage: stockImage ?? this.stockImage,
      levelValue: levelValue ?? this.levelValue,
      isNovice: isNovice ?? this.isNovice,
      interval: interval ?? this.interval,
      ease: ease ?? this.ease,
      nextDate: nextDate ?? this.nextDate,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  String toString() {
    return 'RdbVocabulary(id: $id, user: $user, source: $source, target: $target, sourceLanguageId: $sourceLanguageId, targetLanguageId: $targetLanguageId, tagIds: $tagIds, customImage: $customImage, stockImage: $stockImage, levelValue: $levelValue, isNovice: $isNovice, interval: $interval, ease: $ease, nextDate: $nextDate, created: $created, updated: $updated)';
  }
}
