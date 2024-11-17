import 'package:image_picker/image_picker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

abstract interface class ImageRepository {
  Future<DraftImage?> getImageFromCameraOrFiles({required ImageSource imageSource});
  Future<List<StockImage>> getStockImages(String search);
}
