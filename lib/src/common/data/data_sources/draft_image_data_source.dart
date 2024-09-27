import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/features/details/widgets/camera_gallery_dialog.dart';

final draftImageDataSourceProvider = Provider((ref) => DraftImageDataSource());

class DraftImageDataSource {
  Future<XFile?> getImageFromCameraOrFiles() async {
    final imageSource = await HelperWidgets.showStaticDialog(const CameraGalleryDialog());
    if (imageSource == null) return null;

    try {
      return await ImagePicker().pickImage(source: imageSource);
    } catch (e) {
      Log.error("Failed to open camera or gallery.", exception: e);
      return null;
    }
  }

  /*
  Future<File> _saveCameraFile(String imagePath) async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    final String fileName = const Uuid().v4();
    return await File(imagePath).copy("$path/$fileName");
  }
  */
}
