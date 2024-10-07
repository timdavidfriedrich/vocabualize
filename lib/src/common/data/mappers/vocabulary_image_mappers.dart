import 'package:image_picker/image_picker.dart';
import 'package:vocabualize/src/common/data/models/rdb_vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

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
      sizeVariants: src,
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
  RdbVocabualaryImage? toRdbVocabularyImage() {
    switch (runtimeType) {
      case const (StockImage):
        return (this as StockImage).toRdbVocabularyImage();
      case const (CustomImage):
        return (this as CustomImage).toRdbVocabularyImage();
      case const (FallbackImage):
        return null;
      default:
        throw UnimplementedError('Unknown VocabularyImage type: "$runtimeType"');
    }
  }
}

extension StockImageMappers on StockImage {
  RdbVocabualaryImage toRdbVocabularyImage() {
    return RdbVocabualaryImage(
      type: RdbVocabularyImageType.stock,
      id: id,
      width: width,
      height: height,
      url: url,
      photographer: photographer,
      photographerUrl: photographerUrl,
      src: sizeVariants,
    );
  }
}

extension CustomImageMappers on CustomImage {
  RdbVocabualaryImage toRdbVocabularyImage() {
    return RdbVocabualaryImage(
      type: RdbVocabularyImageType.custom,
      id: id,
      url: url,
    );
  }
}
