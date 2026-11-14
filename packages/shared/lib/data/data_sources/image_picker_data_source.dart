import 'package:shared/domain/entities/image_pick_source.dart';

abstract class ImagePickerDataSource {
  Future<String?> pickImage(ImagePickSource source);
}
