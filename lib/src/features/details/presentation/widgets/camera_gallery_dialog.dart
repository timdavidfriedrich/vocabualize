import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

class CameraGalleryDialog extends StatelessWidget {
  const CameraGalleryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void choose(ImageSource imageSource) {
      context.pop(imageSource);
    }

    void cancel() {
      context.pop();
    }

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
              onPressed: () => choose(ImageSource.camera),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.camera_alt_rounded),
                  const SizedBox(width: 12),
                  Text(AppLocalizations.of(context)?.record_addDetails_takePictureButton ?? ""),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => choose(ImageSource.gallery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.photo_library_rounded),
                  const SizedBox(width: 12),
                  Text(AppLocalizations.of(context)?.record_addDetails_openGalleryButton ?? ""),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
                onPressed: () => cancel(), child: Text(AppLocalizations.of(context)?.record_addDetails_cancelCustomImageButton ?? "")),
          ],
        ),
      ),
    );
  }
}
