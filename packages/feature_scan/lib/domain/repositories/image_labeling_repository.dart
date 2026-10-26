import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/processed_image.dart';

abstract class ImageLabelingRepository {
  Future<AppResult<List<String>>> labelImage({
    required ProcessedImage photo,
    required Language language,
  });
}
