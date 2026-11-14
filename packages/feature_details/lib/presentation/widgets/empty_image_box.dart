import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_context_extensions.dart';
import 'package:feature_details/presentation/extensions/details_image_extensions.dart';
import 'package:feature_details/presentation/widgets/image_choice.dart';
import 'package:feature_details/presentation/widgets/image_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _emptyIconSize = Spacing.xxxl;
const _ownPhotoThumbSize = Spacing.xxl;

class const EmptyImageBox({
  super.key,
  required final ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    final ownPhoto = _choice.ownPhoto;
    return ImageFrame(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: _emptyIconSize, color: context.c.outline),
            const SizedBox(height: Spacing.s),
            Text(
              ownPhoto == null ? context.s.detailsAddPictureTitle : context.s.detailsNoPictureTitle,
              textAlign: TextAlign.center,
              style: context.t.titleLarge,
            ),
            const SizedBox(height: Spacing.m),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: Spacing.s,
              runSpacing: Spacing.s,
              children: switch (ownPhoto) {
                null => [
                  ElevatedButton.icon(
                    onPressed: _choice.isBusy
                        ? null
                        : () => bloc.add(
                            const DetailsPhotoPickRequested(source: ImagePickSource.camera),
                          ),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: Text(context.s.detailsCameraButton),
                  ),
                  TonalButton(
                    onPressed: _choice.isBusy
                        ? null
                        : () => bloc.add(
                            const DetailsPhotoPickRequested(source: ImagePickSource.gallery),
                          ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.image_outlined),
                        const SizedBox(width: Spacing.xs),
                        Text(context.s.detailsGalleryButton),
                      ],
                    ),
                  ),
                ],
                final ownPhoto => [
                  TonalButton(
                    isCompact: true,
                    onPressed: _choice.isBusy
                        ? null
                        : () => bloc.add(DetailsImageToggled(image: ownPhoto)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _OwnPhotoThumb(photo: ownPhoto),
                        const SizedBox(width: Spacing.s),
                        Text(context.s.detailsUseOwnPhotoButton),
                      ],
                    ),
                  ),
                  TonalButton(
                    isCompact: true,
                    onPressed: _choice.isBusy ? null : context.pickPhoto,
                    child: Icon(
                      Icons.photo_camera_outlined,
                      semanticLabel: context.s.detailsRetakeImageButton,
                    ),
                  ),
                ],
              },
            ),
            const SizedBox(height: Spacing.m),
            Text(
              context.s.detailsPexelsHint,
              textAlign: TextAlign.center,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class const _OwnPhotoThumb({
  required final DetailsImage _photo,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = _photo.toImageProvider(isThumbnail: true);
    return Container(
      width: _ownPhotoThumbSize,
      height: _ownPhotoThumbSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusM),
        color: context.c.surfaceContainerLow,
        image: switch (provider) {
          final provider? => DecorationImage(fit: BoxFit.cover, image: provider),
          null => null,
        },
      ),
    );
  }
}
