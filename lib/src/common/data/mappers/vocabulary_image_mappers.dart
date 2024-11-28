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

extension RdbCustomImageStringMappers on String {
  RdbCustomImage? toRdbCustomImage() {
    // TODO: Check if Uri.parse check on RdbCustomImageStringMappers is overkill (performance issues?)
    if (Uri.tryParse(this) == null) {
      return null;
    }
    return RdbCustomImage(
      url: this,
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
      url: url,
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
}

extension CustomImageMappers on CustomImage {
  RdbCustomImage toRdbCustomImage() {
    return RdbCustomImage(
      url: url,
    );
  }
}
