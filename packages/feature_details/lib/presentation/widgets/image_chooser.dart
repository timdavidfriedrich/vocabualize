import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_image_extensions.dart';
import 'package:feature_details/presentation/widgets/camera_gallery_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';
import 'package:shared/presentation/widgets/photo_overlay.dart';

const _gridColumns = 4;
const _overlayRadius = BorderRadius.all(
  Radius.circular(Spacing.radiusL - Spacing.borderWidthMedium),
);

typedef _ImageChoice = ({
  DetailsImage selected,
  DetailsImage? ownPhoto,
  List<StockImage> pageImages,
  bool hasStockImages,
  bool isWaitingForConnection,
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
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: _SelectedImageBox(selected: choice.selected, isLoading: choice.isLoadingImage),
            ),
            const SizedBox(height: Spacing.m),
            if (choice.hasStockImages) const _ProviderHint(),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _gridColumns,
                mainAxisSpacing: Spacing.xxxs,
                crossAxisSpacing: Spacing.xxxs,
              ),
              itemCount: 1 + choice.pageImages.length,
              itemBuilder: (context, index) => switch (index) {
                0 => _OwnPhotoButton(choice: choice),
                _ => _StockImageButton(
                  image: choice.pageImages[index - 1],
                  isSelected: switch (choice.selected) {
                    DetailsStockPhoto(:final image) => image == choice.pageImages[index - 1],
                    _ => false,
                  },
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
  required final DetailsImage _selected,
  required final bool _isLoading,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = _selected.toImageProvider(isThumbnail: false);
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusL),
        border: Border.all(width: Spacing.borderWidthMedium, color: context.c.primary),
        color: context.c.surfaceContainerLow,
        image: switch (provider) {
          final provider? => DecorationImage(
            fit: BoxFit.cover,
            image: ResizeImage(
              provider,
              width: (screenWidth * MediaQuery.devicePixelRatioOf(context)).round(),
            ),
          ),
          null => null,
        },
      ),
      child: switch ((_isLoading, _selected)) {
        (true, _) => const Center(child: CircularProgressIndicator()),
        (false, DetailsNoImage() || DetailsSavedImage(image: NoImage())) => const _NoImageMessage(),
        (
          false,
          DetailsStockPhoto(image: StockImage(:final photographer)) ||
              DetailsSavedImage(image: StockImage(:final photographer)),
        ) =>
          _PhotographerLink(photographer: photographer),
        (false, DetailsSavedImage(image: CustomImage(photographer: final String photographer))) =>
          _PhotographerLink(photographer: photographer),
        (false, DetailsNewPhoto() || DetailsSavedImage(image: CustomImage())) =>
          const _RetakeButton(),
      },
    );
  }
}

class const _NoImageMessage() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.s.detailsNoImageMessage,
        textAlign: TextAlign.center,
        style: context.t.bodyLarge,
      ),
    );
  }
}

class const _RetakeButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhotoOverlay(
      borderRadius: _overlayRadius,
      child: TextButton(
        onPressed: () => _pickPhoto(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.replay_rounded, color: context.overlay.onScrim, size: Spacing.iconS),
            const SizedBox(width: Spacing.xs),
            Text(
              context.s.detailsRetakeImageButton,
              style: context.t.bodySmall?.copyWith(color: context.overlay.onScrim),
            ),
          ],
        ),
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
      borderRadius: _overlayRadius,
      onPressed: () => context.read<DetailsBloc>().add(const DetailsPhotographerLinkOpened()),
    );
  }
}

class const _OwnPhotoButton({
  required final _ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ownPhoto = _choice.ownPhoto;
    return MaterialButton(
      padding: EdgeInsets.zero,
      elevation: 0,
      color: context.c.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
      onPressed: _choice.isBusy
          ? null
          : switch (ownPhoto) {
              final ownPhoto? when ownPhoto != _choice.selected =>
                () => context.read<DetailsBloc>().add(DetailsImageToggled(image: ownPhoto)),
              _ => () => _pickPhoto(context),
            },
      child: switch (ownPhoto) {
        final ownPhoto? => _OwnPhotoPreview(
          photo: ownPhoto,
          isSelected: ownPhoto == _choice.selected,
        ),
        null => Icon(Icons.camera_alt_rounded, color: context.c.primary, size: Spacing.iconXl),
      },
    );
  }
}

class const _OwnPhotoPreview({
  required final DetailsImage _photo,
  required final bool _isSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = _photo.toImageProvider(isThumbnail: true);
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusL),
        border: _isSelected
            ? Border.all(width: Spacing.borderWidthMedium, color: context.c.primary)
            : null,
        color: context.c.surfaceContainerLow,
        image: switch (provider) {
          final provider? => DecorationImage(fit: BoxFit.cover, image: provider),
          null => null,
        },
      ),
      child: Center(
        child: Icon(Icons.camera_alt_rounded, color: context.c.onSurface, size: Spacing.iconXl),
      ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.s.detailsPexelsAttribution, style: context.t.bodySmall),
        IconButton(
          onPressed: () => context.read<DetailsBloc>().add(const DetailsStockPageAdvanced()),
          icon: const Icon(Icons.find_replace_rounded),
        ),
      ],
    );
  }
}

class const _StockImageButton({
  required final StockImage _image,
  required final bool _isSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<DetailsBloc>().add(
        DetailsImageToggled(image: DetailsStockPhoto(image: _image)),
      ),
      borderRadius: BorderRadius.circular(Spacing.radiusL),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusL),
          border: _isSelected
              ? Border.all(width: Spacing.borderWidthMedium, color: context.c.primary)
              : null,
          color: context.c.surfaceContainerLow,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(_image.thumbUrl)),
        ),
        child: _isSelected
            ? Center(child: Icon(Icons.done_rounded, color: context.c.onSurface))
            : null,
      ),
    );
  }
}
