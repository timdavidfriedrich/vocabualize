import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

abstract class ImageRepository {
  Future<AppResult<ProcessedImage>> processImage(String sourcePath);

  Future<AppResult<ProcessedImage>> processStockImage(StockImage image);

  Future<AppResult<()>> discardSourceImage(String sourcePath);
}
