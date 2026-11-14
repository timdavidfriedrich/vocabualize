import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_picker_data_source.dart';

@Injectable(as: ImagePickerDataSource)
class const ImagePickerDataSourceImpl() implements ImagePickerDataSource {
  @override
  Future<String?> pickImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source, requestFullMetadata: false);
    return file?.path;
  }
}
