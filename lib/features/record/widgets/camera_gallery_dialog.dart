import 'package:flutter/material.dart';
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
                children: const [
                  Icon(Icons.camera_alt_rounded),
                  SizedBox(width: 12),
                  Text("Take picture"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _return(ImageSource.gallery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.photo_library_rounded),
                  SizedBox(width: 12),
                  Text("Open gallery"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => _cancel(), child: const Text("Cancel")),
          ],
        ),
      ),
    );
  }
}
