import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _imageKindNone = "none";
const _imageKindCustom = "custom";
const _imageKindStock = "stock";

extension LocalVocabularyMappers on LocalVocabulary {
  Vocabulary toVocabulary({
    required Map<String, ({String? full, String? thumbnail})> imagePaths,
    required Set<String> tagIds,
  }) {
    return Vocabulary(
      id: id.toString(),
      source: source,
      target: target,
      sourceLanguage: sourceLanguageCode.toLanguage(),
      targetLanguage: targetLanguageCode.toLanguage(),
      level: level,
      isNovice: isNovice,
      intervalMinutes: intervalMinutes,
      ease: ease,
      nextReviewAt: nextReviewAt.toUtc(),
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
      source: source,
      target: target,
      sourceLanguageCode: sourceLanguage.toLanguageCode(),
      targetLanguageCode: targetLanguage.toLanguageCode(),
      level: level,
      isNovice: isNovice,
      intervalMinutes: intervalMinutes,
      ease: ease,
      nextReviewAt: nextReviewAt.toUtc(),
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
    );
  }
}

extension VocabularyImageKindMappers on VocabularyImage {
  String get kind => switch (this) {
    NoImage() => _imageKindNone,
    CustomImage() => _imageKindCustom,
    StockImage() => _imageKindStock,
  };
}
