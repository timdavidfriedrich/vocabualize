import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/image_pick_source.dart';

abstract class ImagePickerDataSource {
  Future<String?> pickImage(ImagePickSource source);
}

@Injectable(as: ImagePickerDataSource)
class const ImagePickerDataSourceImpl() implements ImagePickerDataSource {
  @override
  Future<String?> pickImage(ImagePickSource source) async {
    final file = await ImagePicker().pickImage(
      source: switch (source) {
        ImagePickSource.gallery => ImageSource.gallery,
        ImagePickSource.camera => ImageSource.camera,
      },
      requestFullMetadata: false,
    );
    return file?.path;
  }
}
