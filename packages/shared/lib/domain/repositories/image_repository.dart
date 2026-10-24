import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/processed_image.dart';

abstract class ImageRepository {
  Future<AppResult<ProcessedImage>> processImage(String sourcePath);
}
