import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/src/common/data/mappers/language_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/tag_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_image_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_user.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary.dart';
import 'package:vocabualize/src/common/data/utils/date_parser.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

extension RecordModelMappers on RecordModel {
  RdbVocabulary toRdbVocabulary() {
    return RdbVocabulary(
      id: id,
      //user: data["user"] ?? "",
      source: data["source"] ?? "",
      target: data["target"] ?? "",
      // TODO: Add language convertion
      //sourceLanguage: data["sourceLanguage"] ?? "",
      //targetLanguage: data["targetLanguage"] ?? "",
      // TODO: Add tag convertion
      tags: [], //(data["tags"] as List<String>) ?? [],
      // TODO: Add image convertion
      image: null, // data["image"] != null ? RdbVocabualaryImage.fromRecord(data["image"]) : null,
      levelValue: data["levelValue"] ?? 0.0,
      isNovice: data["isNovice"] ?? true,
      interval: data["interval"] ?? DueAlgorithmConstants.initialInterval,
      ease: data["ease"] ?? DueAlgorithmConstants.initialEase,
      nextDate: data["nextDate"] ?? DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      created: data["created"] ?? "",
      updated: data["updated"] ?? "",
    );
  }
}

extension VocabularyModelMappers on RdbVocabulary {
  Vocabulary toVocabulary() {
    return Vocabulary(
      id: id,
      source: source,
      target: target,
      sourceLanguage: sourceLanguage.toLanguage(),
      targetLanguage: targetLanguage.toLanguage(),
      tags: tags.map((rdbTag) => rdbTag.toTag()).toList(),
      image: image?.toVocabularyImage() ?? const FallbackImage(),
      level: Level.withValue(value: levelValue),
      isNovice: isNovice,
      interval: interval,
      ease: ease,
      nextDate: DateParser.parseOrNull(nextDate),
      created: DateParser.parseOrNull(created),
      updated: DateParser.parseOrNull(updated),
    );
  }

  RecordModel toRecordModel() {
    return RecordModel(
      id: id,
      data: {
        "user": user.id,
        "source": source,
        "target": target,
        // TODO: Add language convertion
        "sourceLanguage": sourceLanguage.id, //sourceLanguage.toRecordModel(),
        "targetLanguage": targetLanguage.id, //targetLanguage.toRecordModel(),
        // TODO: Add tag convertion
        "tags": "", // tags.map((tag) => tag.toRecordModel()).toList(),
        // TODO: Add image convertion
        "image": "", // image?.toRecordModel(),
        "levelValue": levelValue,
        "isNovice": isNovice,
        "interval": interval,
        "ease": ease,
        "nextDate": nextDate,
        "created": created,
        "updated": updated,
      },
    );
  }
}

extension VocabularyMappers on Vocabulary {
  RdbVocabulary toRdbVocabulary() {
    return RdbVocabulary(
      id: id ?? "",
      // TODO: Replace with current user id
      user: const RdbUser(),
      source: source,
      target: target,
      sourceLanguage: sourceLanguage.toRdbLanguage(),
      targetLanguage: targetLanguage.toRdbLanguage(),
      tags: tags.map((tag) => tag.toRdbTag()).toList(),
      image: image.toRdbVocabularyImage(),
      levelValue: level.value,
      isNovice: isNovice,
      interval: interval,
      ease: ease,
      nextDate: nextDate.toIso8601String(),
      created: created.toIso8601String(),
      updated: updated.toIso8601String(),
    );
  }
}
