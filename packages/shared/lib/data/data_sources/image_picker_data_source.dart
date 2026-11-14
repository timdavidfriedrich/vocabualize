import 'package:image_picker/image_picker.dart';

abstract class ImagePickerDataSource {
  Future<String?> pickImage(ImageSource source);
}
