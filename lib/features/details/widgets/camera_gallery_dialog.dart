import 'package:vocabualize/constants/common_imports.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vocabualize/constants/keys.dart';

class CameraGalleryDialog extends StatelessWidget {
  const CameraGalleryDialog({super.key});

  _return(ImageSource imageSource) {
    Navigator.pop(Keys.context, imageSource);
  }

  _cancel() {
    Navigator.pop(Keys.context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 64),
      contentPadding: const EdgeInsets.all(12),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _return(ImageSource.camera),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.camera_alt_rounded),
                  const SizedBox(width: 12),
                  Text(AppLocalizations.of(context).record_addDetails_takePictureButton),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _return(ImageSource.gallery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.photo_library_rounded),
                  const SizedBox(width: 12),
                  Text(AppLocalizations.of(context).record_addDetails_openGalleryButton),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => _cancel(), child: Text(AppLocalizations.of(context).record_addDetails_cancelCustomImageButton)),
          ],
        ),
      ),
    );
  }
}
