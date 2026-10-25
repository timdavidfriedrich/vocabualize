import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<ImagePickSource?> requestsImagePickSource(BuildContext context) {
  return showDialog<ImagePickSource>(
    context: context,
    builder: (dialogContext) => const _CameraGalleryDialog(),
  );
}

class const _CameraGalleryDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.symmetric(horizontal: Spacing.xxxxl),
      contentPadding: const EdgeInsets.all(Spacing.s),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SourceButton(
              source: ImagePickSource.camera,
              icon: Icons.camera_alt_rounded,
              label: context.s.detailsTakePictureButton,
            ),
            const SizedBox(height: Spacing.s),
            _SourceButton(
              source: ImagePickSource.gallery,
              icon: Icons.photo_library_rounded,
              label: context.s.detailsOpenGalleryButton,
            ),
            const SizedBox(height: Spacing.s),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.s.cancel),
            ),
          ],
        ),
      ),
    );
  }
}

class const _SourceButton({
  required final ImagePickSource _source,
  required final IconData _icon,
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(_source),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon),
          const SizedBox(width: Spacing.s),
          Flexible(child: Text(_label)),
        ],
      ),
    );
  }
}
