import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log/log.dart';

final draftImageDataSourceProvider = Provider((ref) => DraftImageDataSource());

class DraftImageDataSource {
  Future<XFile?> getImageFromCameraOrFiles({
    required ImageSource imageSource,
  }) async {
    try {
      return await ImagePicker().pickImage(source: imageSource);
    } catch (e) {
      Log.error("Failed to open camera or gallery.", exception: e);
      return null;
    }
  }
}
