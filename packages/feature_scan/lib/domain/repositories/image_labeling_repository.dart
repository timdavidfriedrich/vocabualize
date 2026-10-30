import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/image_label.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/processed_image.dart';

abstract class ImageLabelingRepository {
  Future<AppResult<List<ImageLabel>>> labelImage({
    required ProcessedImage photo,
    required Language language,
  });
}
