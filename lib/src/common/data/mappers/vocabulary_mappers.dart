import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/constants/secrets/pocketbase_secrets.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_image_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_user.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';
import 'package:vocabualize/src/common/data/utils/date_parser.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

extension on String {
  // TODO: Remove String.toFileUrl() extension and find an alternative using pb.files.getUrl(record, filename)
  String toFileUrl(String recordId, String collectionName) {
    return "${PocketbaseSecrets.databaseUrl}/api/files/$collectionName/$recordId/$this";
  }
}

extension RecordModelMappers on RecordModel {
  RdbVocabulary toRdbVocabulary() {
    final Map<String, dynamic>? stockImageJson = getDataValue("stockImage", null);
    final stockImage = stockImageJson?.toRdbStockImage();
    final customImageName = getStringValue("customImage", "");
    final customImageUrl = customImageName.isNotEmpty ? customImageName.toFileUrl(id, collectionName) : null;
    final customImage = customImageUrl != null ? RdbCustomImage(id: "", fileName: customImageUrl) : null;
    return RdbVocabulary(
      id: id,
      //user: data["user"] ?? "",
      source: getStringValue("source", ""),
      target: getStringValue("target", ""),
      // TODO: Add language convertion
      //sourceLanguageId: data["sourceLanguageId"] ?? "",
      //targetLanguageId: data["targetLanguageId"] ?? "",
      // TODO: Add tag convertion
      tagIds: [], //(data["tagIds"] as List<String>) ?? [],
      customImage: customImage,
      stockImage: stockImage,
      levelValue: getDoubleValue("levelValue", 0.0),
      isNovice: getBoolValue("isNovice", true),
      interval: getIntValue("interval", DueAlgorithmConstants.initialInterval),
      ease: getDoubleValue("ease", DueAlgorithmConstants.initialEase),
      nextDate: getStringValue("nextDate", DateTime.now().subtract(const Duration(days: 1)).toIso8601String()),
      created: created,
      updated: updated,
    );
  }
}

extension VocabularyModelMappers on RdbVocabulary {
  Vocabulary toVocabulary() {
    final rdbImage = customImage ?? stockImage;
    return Vocabulary(
      id: id,
      source: source,
      target: target,
      sourceLanguageId: sourceLanguageId,
      targetLanguageId: targetLanguageId,
      tagIds: tagIds,
      image: rdbImage?.toVocabularyImage() ?? const FallbackImage(),
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
      id: id ?? "",
      data: {
        "user": user.id,
        "source": source,
        "target": target,
        "sourceLanguage": sourceLanguageId,
        "targetLanguage": targetLanguageId,
        "tags": tagIds,
        "customImage": customImage?.fileName,
        "stockImage": stockImage?.toRecordModel().toJson(),
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
    final rdbImage = image.toRdbImage();
    final customImage = rdbImage is RdbCustomImage ? rdbImage : null;
    final stockImage = rdbImage is RdbStockImage ? rdbImage : null;
    return RdbVocabulary(
      id: id,
      // TODO: Replace with current user id
      user: const RdbUser(),
      source: source,
      target: target,
      sourceLanguageId: sourceLanguageId,
      targetLanguageId: targetLanguageId,
      tagIds: tagIds,
      customImage: customImage,
      stockImage: stockImage,
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
