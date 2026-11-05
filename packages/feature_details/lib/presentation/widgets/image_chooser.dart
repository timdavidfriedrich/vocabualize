import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_image_extensions.dart';
import 'package:feature_details/presentation/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';
import 'package:shared/presentation/widgets/photo_overlay.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _gridColumns = 4;
const _selectedInset = Spacing.borderWidthThick + Spacing.borderWidthMedium;
const _emptyIconSize = Spacing.xxxl;
const _ownPhotoThumbSize = Spacing.xxl;

typedef _ImageChoice = ({
  DetailsImage selected,
  DetailsImage? ownPhoto,
  List<StockImage> pageImages,
  bool hasStockImages,
  bool isWaitingForConnection,
  bool isSearchingPhotos,
  bool isBusy,
  bool isLoadingImage,
});

class const ImageChooser({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailsBloc, DetailsState, _ImageChoice?>(
      selector: (state) => switch (state) {
        DetailsEditing(
          :final selectedImage,
          :final ownPhoto,
          :final stockImages,
          :final stockPage,
          :final pendingLookup,
          :final isSearchingPhotos,
          :final runningAction,
        ) =>
          (
            selected: selectedImage,
            ownPhoto: ownPhoto,
            pageImages: stockImages
                .skip(stockPage * stockImagesPerPage)
                .take(stockImagesPerPage)
                .toList(),
            hasStockImages: stockImages.isNotEmpty,
            isWaitingForConnection: pendingLookup != null,
            isSearchingPhotos: isSearchingPhotos,
            isBusy: runningAction != null,
            isLoadingImage:
                runningAction == DetailsAction.lookup || runningAction == DetailsAction.photoPick,
          ),
        _ => null,
      },
      builder: (context, choice) => switch (choice) {
        null => const SizedBox.shrink(),
        final choice => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(aspectRatio: 1, child: _SelectedImageBox(choice: choice)),
            const SizedBox(height: Spacing.s),
            if (choice.hasStockImages)
              const _ProviderHint()
            else if (choice.isSearchingPhotos) ...[
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(Spacing.radiusS),
                backgroundColor: context.c.surfaceContainerLow,
              ),
              const SizedBox(height: Spacing.m),
            ],
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _gridColumns,
                mainAxisSpacing: Spacing.xxs,
                crossAxisSpacing: Spacing.xxs,
              ),
              itemCount: 1 + choice.pageImages.length,
              itemBuilder: (context, index) => switch (index) {
                0 => _OwnPhotoTile(choice: choice),
                _ => _StockImageTile(
                  image: choice.pageImages[index - 1],
                  isSelected: switch (choice.selected) {
                    DetailsStockPhoto(:final image) => image == choice.pageImages[index - 1],
                    _ => false,
                  },
                  isBusy: choice.isBusy,
                ),
              },
            ),
            if (choice.isWaitingForConnection) ...[
              const SizedBox(height: Spacing.m),
              ConnectionRequiredNotice(message: context.s.detailsOfflineMessage),
            ],
          ],
        ),
      },
    );
  }
}

class const _SelectedImageBox({
  required final _ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = _choice.selected;
    final provider = selected.toImageProvider(isThumbnail: false);
    if (_choice.isLoadingImage) {
      return const _ImageFrame(child: Center(child: CircularProgressIndicator()));
    }
    if (provider == null) return _EmptyImageBox(choice: _choice);
    final width = MediaQuery.sizeOf(context).width * MediaQuery.devicePixelRatioOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
        border: Border.all(width: Spacing.borderWidthThick, color: context.c.primary),
        color: context.c.surfaceContainerLow,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: ResizeImage(provider, width: width.round()),
        ),
      ),
      child: switch (selected) {
        DetailsStockPhoto(image: StockImage(:final photographer)) ||
        DetailsSavedImage(image: StockImage(:final photographer)) => _PhotographerLink(
          photographer: photographer,
        ),
        DetailsSavedImage(image: CustomImage(photographer: final String photographer)) =>
          _PhotographerLink(photographer: photographer),
        DetailsNewPhoto() || DetailsSavedImage() || DetailsNoImage() => PhotoPillButton(
          label: context.s.detailsRetakeImageButton,
          leadingIcon: Icons.replay_rounded,
          onPressed: _choice.isBusy ? null : () => _pickPhoto(context),
        ),
      },
    );
  }
}

class const _ImageFrame({
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
        color: context.c.surfaceContainerLowest,
      ),
      child: _child,
    );
  }
}

class const _EmptyImageBox({
  required final _ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    final ownPhoto = _choice.ownPhoto;
    return _ImageFrame(
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
                    onPressed: _choice.isBusy ? null : () => _pickPhoto(context),
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

class const _PhotographerLink({
  required final String? _photographer,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhotoCreditButton(
      photographer: _photographer,
      onPressed: () => context.read<DetailsBloc>().add(const DetailsPhotographerLinkOpened()),
    );
  }
}

class const _OwnPhotoTile({
  required final _ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ownPhoto = _choice.ownPhoto;
    if (ownPhoto == null) {
      return Material(
        color: context.c.primaryContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _choice.isBusy ? null : () => _pickPhoto(context),
          child: Icon(
            Icons.photo_camera_outlined,
            color: context.c.primary,
            size: Spacing.iconXl,
            semanticLabel: context.s.detailsTakePictureButton,
          ),
        ),
      );
    }
    final isSelected = ownPhoto == _choice.selected;
    return _ImageTile(
      image: ownPhoto.toImageProvider(isThumbnail: true),
      isSelected: isSelected,
      icon: Icons.photo_camera_outlined,
      onTap: switch ((_choice.isBusy, isSelected)) {
        (true, _) => null,
        (false, true) => () => _pickPhoto(context),
        (false, false) => () => context.read<DetailsBloc>().add(
          DetailsImageToggled(image: ownPhoto),
        ),
      },
      onRemoved: null,
    );
  }
}

class const _StockImageTile({
  required final StockImage _image,
  required final bool _isSelected,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    void toggle() => bloc.add(DetailsImageToggled(image: DetailsStockPhoto(image: _image)));
    return _ImageTile(
      image: NetworkImage(_image.thumbUrl),
      isSelected: _isSelected,
      icon: null,
      onTap: _isBusy ? null : toggle,
      onRemoved: _isSelected && !_isBusy ? toggle : null,
    );
  }
}

class const _ImageTile({
  required final ImageProvider? _image,
  required final bool _isSelected,
  required final IconData? _icon,
  required final VoidCallback? _onTap,
  required final VoidCallback? _onRemoved,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inset = _isSelected ? _selectedInset : 0.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Spacing.radiusL),
              border: _isSelected
                  ? Border.all(width: Spacing.borderWidthThick, color: context.c.primary)
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(inset),
              child: Material(
                color: context.c.surfaceContainerLow,
                borderRadius: BorderRadius.circular(Spacing.radiusL - inset),
                clipBehavior: Clip.antiAlias,
                child: Ink(
                  decoration: BoxDecoration(
                    image: switch (_image) {
                      final image? => DecorationImage(fit: BoxFit.cover, image: image),
                      null => null,
                    },
                  ),
                  child: InkWell(
                    onTap: _onTap,
                    child: switch (_icon) {
                      final icon? => Icon(
                        icon,
                        size: Spacing.iconXl,
                        color: context.overlay.onScrim,
                        shadows: [Shadow(color: context.overlay.scrim, blurRadius: Spacing.xs)],
                      ),
                      null => null,
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_onRemoved case final onRemoved?)
          Positioned(
            top: -Spacing.xxxs,
            right: -Spacing.xxxs,
            child: Material(
              color: context.c.inverseSurface,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onRemoved,
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.xxxs),
                  child: Icon(
                    Icons.close_rounded,
                    size: Spacing.iconS,
                    color: context.c.onInverseSurface,
                    semanticLabel: context.s.detailsRemovePictureTooltip,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Future<void> _pickPhoto(BuildContext context) async {
  final bloc = context.read<DetailsBloc>();
  final source = await requestsImagePickSource(context);
  if (source != null) bloc.add(DetailsPhotoPickRequested(source: source));
}

class const _ProviderHint() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.xxs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.detailsPexelsAttribution,
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ),
          IconButton(
            onPressed: () => context.read<DetailsBloc>().add(const DetailsStockPageAdvanced()),
            tooltip: context.s.detailsMorePicturesTooltip,
            icon: const Icon(Icons.find_replace_rounded),
          ),
        ],
      ),
    );
  }
}
