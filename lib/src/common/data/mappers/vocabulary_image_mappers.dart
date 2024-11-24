import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/extensions/iterable_extensions.dart';

extension _SrcMappers on Map<String, dynamic>? {
  Map<ImageSize, String>? toSizeVariants() {
    return this?.entries.fold<Map<ImageSize, String>>({}, (result, entry) {
      if (entry.value is! String) {
        return result;
      }
      final size = ImageSize.values.firstWhereOrNull(
        (e) => e?.name == entry.key,
      );
      if (size == null) {
        return result;
      }
      result[size] = entry.value;
      return result;
    });
  }
}

extension _SizeVariantsMappers on Map<ImageSize, String>? {
  Map<String, dynamic>? toSrc() {
    return this?.entries.fold<Map<String, dynamic>>({}, (result, entry) {
      result[entry.key.name] = entry.value;
      return result;
    });
  }
}

// TODO: Remove RdbVocabularyImageMappers, after removing RdbVocabularyImage ?? still relevant??
extension RdbVocabularyImageMappers on RdbVocabualaryImage {
  VocabularyImage toVocabularyImage() {
    switch (type) {
      case RdbVocabularyImageType.stock:
        return toStockImage();
      case RdbVocabularyImageType.custom:
        return toCustomImage();
    }
  }

  StockImage toStockImage() {
    return StockImage(
      id: id,
      width: width,
      height: height,
      url: url,
      photographer: photographer,
      photographerUrl: photographerUrl,
      sizeVariants: src.toSizeVariants(),
    );
  }

  CustomImage toCustomImage() {
    return CustomImage(
      id: id,
      url: url,
    );
  }
}

extension XFileMappers on XFile {
  Future<DraftImage> toDraftImage() async {
    return DraftImage(
      content: await readAsBytes(),
    );
  }
}

extension VocabularyImageMappers on VocabularyImage {
  RdbImage? toRdbImage() {
    switch (runtimeType) {
      case const (StockImage):
        return (this as StockImage).toRdbStockImage();
      case const (CustomImage):
        return (this as CustomImage).toRdbCustomImage();
      case const (FallbackImage):
        return null;
      default:
        throw UnimplementedError(
            'Unknown VocabularyImage type: "$runtimeType"');
    }
  }

  // TODO: Remove toRdbVocabularyImage, after removing RdbVocabularyImage
  RdbVocabualaryImage? toRdbVocabularyImage() {
    switch (runtimeType) {
      case const (StockImage):
        return (this as StockImage).toRdbVocabularyImage();
      case const (CustomImage):
        return (this as CustomImage).toRdbVocabularyImage();
      case const (FallbackImage):
        return null;
      default:
        throw UnimplementedError(
            'Unknown VocabularyImage type: "$runtimeType"');
    }
  }
}

extension RdbStockImageJsonMappers on Map<String, dynamic> {
  RdbStockImage toRdbStockImage() {
    return RdbStockImage(
      id: this['id'].toString(),
      width: this['width'] as int,
      height: this['height'] as int,
      url: this['src']['original'] as String,
      photographer: this['photographer'] as String?,
      photographerUrl: this['photographerUrl'] as String?,
      src: this['src'] as Map<String, dynamic>?,
    );
  }
}

extension RdbCustomImageJsonMappers on Map<String, dynamic> {
  RdbCustomImage toRdbCustomImage() {
    return RdbCustomImage(
      id: (this['id'] as int?).toString(),
      fileName: this['imageUrl'] as String,
    );
  }
}

extension RdbImageMappers on RdbImage {
  VocabularyImage toVocabularyImage() {
    switch (runtimeType) {
      case const (RdbStockImage):
        return (this as RdbStockImage).toStockImage();
      case const (RdbCustomImage):
        return (this as RdbCustomImage).toCustomImage();
      default:
        throw UnimplementedError('Unknown RdbImage type: "$runtimeType"');
    }
  }
}

extension RdbStockImageMappers on RdbStockImage {
  StockImage toStockImage() {
    return StockImage(
      id: id,
      width: width,
      height: height,
      url: url,
      photographer: photographer,
      photographerUrl: photographerUrl,
      sizeVariants: src.toSizeVariants(),
    );
  }

  RecordModel toRecordModel() {
    return RecordModel(
      id: id,
      data: {
        "width": width,
        "height": height,
        "src": src,
        "photographer": photographer,
        "photographerUrl": photographerUrl,
      },
    );
  }
}

extension RdbCustomImageMappers on RdbCustomImage {
  CustomImage toCustomImage() {
    return CustomImage(
      id: id,
      url: fileName,
    );
  }
}

extension StockImageMappers on StockImage {
  RdbStockImage toRdbStockImage() {
    return RdbStockImage(
      id: id,
      width: width,
      height: height,
      url: url,
      photographer: photographer,
      photographerUrl: photographerUrl,
      src: sizeVariants.toSrc(),
    );
  }

  // TODO: Remove toRdbVocabularyImage, after removing RdbVocabularyImage
  RdbVocabualaryImage toRdbVocabularyImage() {
    return RdbVocabualaryImage(
      type: RdbVocabularyImageType.stock,
      id: id,
      width: width,
      height: height,
      url: url,
      photographer: photographer,
      photographerUrl: photographerUrl,
      src: sizeVariants.toSrc(),
    );
  }
}

extension CustomImageMappers on CustomImage {
  RdbCustomImage toRdbCustomImage() {
    return RdbCustomImage(
      id: id,
      fileName: url,
    );
  }

  // TODO: Remove toRdbVocabularyImage, after removing RdbVocabularyImage
  RdbVocabualaryImage toRdbVocabularyImage() {
    return RdbVocabualaryImage(
      type: RdbVocabularyImageType.custom,
      id: id,
      url: url,
    );
  }
}
