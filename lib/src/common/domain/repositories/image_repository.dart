import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

abstract interface class ImageRepository {
  Future<DraftImage?> getImageFromCameraOrFiles();
  Future<List<StockImage>> getStockImages(String search);
}
