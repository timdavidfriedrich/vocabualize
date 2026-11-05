import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

Future<ImagePickSource?> requestsImagePickSource(BuildContext context) {
  return showModalBottomSheet<ImagePickSource>(
    context: context,
    showDragHandle: true,
    backgroundColor: context.c.surfaceContainerLowest,
    builder: (sheetContext) => const _ImageSourceSheet(),
  );
}

class const _ImageSourceSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _SourceTile(
                    source: ImagePickSource.camera,
                    icon: Icons.photo_camera_outlined,
                    label: context.s.detailsTakePictureButton,
                  ),
                ),
                const SizedBox(width: Spacing.s),
                Expanded(
                  child: _SourceTile(
                    source: ImagePickSource.gallery,
                    icon: Icons.image_outlined,
                    label: context.s.detailsOpenGalleryButton,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.s),
            TonalButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.s.cancel),
            ),
          ],
        ),
      ),
    );
  }
}

class const _SourceTile({
  required final ImagePickSource _source,
  required final IconData _icon,
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.primaryContainer,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(_source),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xl),
          child: Column(
            children: [
              Icon(_icon, color: context.c.primary, size: Spacing.iconXl),
              const SizedBox(height: Spacing.xs),
              Text(
                _label,
                textAlign: TextAlign.center,
                style: context.t.titleMedium?.copyWith(color: context.c.onPrimaryContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
