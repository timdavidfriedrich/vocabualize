import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/image_pick_source.dart';

abstract class ImagePickerRepository {
  Future<AppResult<String?>> pickImage(ImagePickSource source);

  Future<AppResult<()>> discardImage(String path);
}
