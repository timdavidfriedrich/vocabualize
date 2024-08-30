import 'package:vocabualize/src/common/data/mappers/language_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/tag_mappers.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_image_mappers.dart';
import 'package:vocabualize/src/common/data/models/rdb_user.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary.dart';
import 'package:vocabualize/src/common/data/utils/date_parser.dart';
import 'package:vocabualize/src/common/domain/entities/level.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

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
}

extension VocabularyMappers on Vocabulary {
  RdbVocabulary toRdbVocabulary() {
    return RdbVocabulary(
      id: id,
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
