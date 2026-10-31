import 'package:shared/data/extensions/uuid_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/models/local_progress_stage.dart';
import 'package:shared/data/models/local_translation_origin.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _imageKindNone = "none";
const _imageKindCustom = "custom";
const _imageKindStock = "stock";

final _originsByValue = {for (final origin in LocalTranslationOrigin.values) origin.value: origin};
final _stagesByValue = {for (final stage in LocalProgressStage.values) stage.value: stage};

extension LocalVocabularyMappers on LocalVocabulary {
  Vocabulary toVocabulary({
    required Map<String, ({String? full, String? thumbnail})> imagePaths,
    required Set<String> tagIds,
  }) {
    return Vocabulary(
      id: id.toString(),
      translations: {
        for (final translation in translations ?? const <LocalTranslation>[])
          if (translation.languageCode.toLanguage() case final language
              when language != Language.unknown)
            language: translation.toTranslation(),
      },
      progress: {
        for (final row in progress ?? const <LocalProgress>[])
          if (row.languageCode.toLanguage() case final language when language != Language.unknown)
            language: row.toProgress(),
      },
      image: _toVocabularyImage(imagePaths),
      tagIds: tagIds,
      createdAt: createdAt.toUtc(),
    );
  }

  VocabularyImage _toVocabularyImage(
    Map<String, ({String? full, String? thumbnail})> imagePaths,
  ) {
    return switch ((imageKind, customImageId, stockImageId, stockImageUrl, stockImageThumbUrl)) {
      (_imageKindCustom, final String imageId, _, _, _) => CustomImage(
        imageId: imageId,
        fullPath: imagePaths[imageId]?.full,
        thumbnailPath: imagePaths[imageId]?.thumbnail,
        photographer: stockPhotographer,
        photographerUrl: stockPhotographerUrl,
      ),
      (_imageKindStock, _, final String id, final String url, final String thumbUrl) => StockImage(
        id: id,
        url: url,
        thumbUrl: thumbUrl,
        photographer: stockPhotographer,
        photographerUrl: stockPhotographerUrl,
      ),
      _ => const NoImage(),
    };
  }
}

extension VocabularyMappers on Vocabulary {
  LocalVocabulary toLocalVocabulary() {
    final customImage = switch (image) {
      final CustomImage customImage => customImage,
      _ => null,
    };
    final stockImage = switch (image) {
      final StockImage stockImage => stockImage,
      _ => null,
    };
    return LocalVocabulary(
      id: UuidValue.withValidation(id),
      imageKind: image.kind,
      customImageId: customImage?.imageId,
      customImageUploadedAt: null,
      stockImageId: stockImage?.id,
      stockImageUrl: stockImage?.url,
      stockImageThumbUrl: stockImage?.thumbUrl,
      stockPhotographer: switch (image) {
        CustomImage(:final photographer) || StockImage(:final photographer) => photographer,
        NoImage() => null,
      },
      stockPhotographerUrl: switch (image) {
        CustomImage(:final photographerUrl) ||
        StockImage(:final photographerUrl) => photographerUrl,
        NoImage() => null,
      },
      createdAt: createdAt.toUtc(),
      extras: null,
      translations: null,
      progress: null,
    );
  }
}

extension LocalTranslationMappers on LocalTranslation {
  Translation toTranslation() {
    return Translation(
      language: languageCode.toLanguage(),
      text: text,
      origin: origin.toTranslationOrigin(),
    );
  }
}

extension TranslationMappers on Translation {
  LocalTranslation toLocalTranslation({required UuidValue vocabularyId}) {
    final languageCode = language.toLanguageCode();
    return LocalTranslation(
      id: vocabularyId.languageRowId(languageCode),
      vocabularyId: vocabularyId,
      languageCode: languageCode,
      text: text,
      origin: origin.value,
      extras: null,
    );
  }
}

extension LocalProgressMappers on LocalProgress {
  Progress toProgress() {
    return Progress(
      language: languageCode.toLanguage(),
      stage: stage.toProgressStage(),
      level: level,
      intervalMinutes: intervalMinutes,
      ease: ease,
      nextReviewAt: nextReviewAt.toUtc(),
      createdAt: createdAt.toUtc(),
    );
  }
}

extension ProgressMappers on Progress {
  LocalProgress toLocalProgress({required UuidValue vocabularyId}) {
    final languageCode = language.toLanguageCode();
    return LocalProgress(
      id: vocabularyId.languageRowId(languageCode),
      vocabularyId: vocabularyId,
      languageCode: languageCode,
      stage: stage.value,
      level: level,
      intervalMinutes: intervalMinutes,
      ease: ease,
      nextReviewAt: nextReviewAt.toUtc(),
      createdAt: createdAt.toUtc(),
      extras: null,
    );
  }
}

extension TranslationOriginValueMappers on String {
  TranslationOrigin toTranslationOrigin() => switch (_originsByValue[this]) {
    LocalTranslationOrigin.entered => TranslationOrigin.entered,
    LocalTranslationOrigin.translated => TranslationOrigin.translated,
    LocalTranslationOrigin.edited => TranslationOrigin.edited,
    null => TranslationOrigin.unknown,
  };

  ProgressStage toProgressStage() => switch (_stagesByValue[this]) {
    LocalProgressStage.waiting => ProgressStage.waiting,
    LocalProgressStage.shortTerm => ProgressStage.shortTerm,
    LocalProgressStage.longTerm => ProgressStage.longTerm,
    null => ProgressStage.unknown,
  };
}

extension TranslationOriginMappers on TranslationOrigin {
  String get value => switch (this) {
    TranslationOrigin.entered => LocalTranslationOrigin.entered.value,
    TranslationOrigin.translated => LocalTranslationOrigin.translated.value,
    TranslationOrigin.edited || TranslationOrigin.unknown => LocalTranslationOrigin.edited.value,
  };
}

extension ProgressStageMappers on ProgressStage {
  String get value => switch (this) {
    ProgressStage.waiting => LocalProgressStage.waiting.value,
    ProgressStage.shortTerm || ProgressStage.unknown => LocalProgressStage.shortTerm.value,
    ProgressStage.longTerm => LocalProgressStage.longTerm.value,
  };
}

extension VocabularyImageKindMappers on VocabularyImage {
  String get kind => switch (this) {
    NoImage() => _imageKindNone,
    CustomImage() => _imageKindCustom,
    StockImage() => _imageKindStock,
  };
}
