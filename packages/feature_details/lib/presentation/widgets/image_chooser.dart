import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/image_choice.dart';
import 'package:feature_details/presentation/widgets/image_tiles.dart';
import 'package:feature_details/presentation/widgets/selected_image_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';

const _gridColumns = 4;
const _skeletonPulse = Duration(milliseconds: 900);

class const ImageChooser({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DetailsBloc, DetailsState, ImageChoice?>(
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
            stockImages: stockImages,
            stockPage: stockPage,
            isWaitingForConnection: pendingLookup != null,
            isSearchingPhotos: isSearchingPhotos,
            isBusy: runningAction != null,
            isLoadingImage: runningAction == DetailsAction.photoPick,
          ),
        DetailsLoading() ||
        DetailsDuplicateFound() ||
        DetailsExistingFound() ||
        DetailsText() ||
        DetailsAdded() ||
        DetailsClosed() ||
        DetailsFailure() => null,
      },
      builder: (context, choice) => switch (choice) {
        null => const SizedBox.shrink(),
        final choice => _Content(choice: choice),
      },
    );
  }
}

class const _Content({
  required final ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final choice = _choice;
    final pageImages = choice.stockImages
        .skip(choice.stockPage * stockImagesPerPage)
        .take(stockImagesPerPage)
        .toList();
    final isLoadingStock = choice.stockImages.isEmpty && choice.isSearchingPhotos;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(aspectRatio: 1, child: SelectedImageBox(choice: choice)),
        const SizedBox(height: Spacing.s),
        if (choice.stockImages.isNotEmpty || isLoadingStock)
          _ProviderHint(canAdvance: choice.stockImages.isNotEmpty),
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
          itemCount: 1 + (isLoadingStock ? stockImagesPerPage : pageImages.length),
          itemBuilder: (context, index) => switch (index) {
            0 => OwnPhotoTile(choice: choice),
            _ when isLoadingStock => const _SkeletonTile(),
            _ => StockImageTile(
              image: pageImages[index - 1],
              isSelected: switch (choice.selected) {
                DetailsStockPhoto(:final image) => image == pageImages[index - 1],
                DetailsNoImage() || DetailsNewPhoto() || DetailsSavedImage() => false,
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
    );
  }
}

class const _SkeletonTile() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: _skeletonPulse);
    useEffect(() {
      controller.repeat(reverse: true);
      return null;
    }, [controller]);
    final pulse = useAnimation(controller);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusL),
        color: Color.lerp(context.c.surfaceContainerLow, context.c.surfaceContainerHighest, pulse),
      ),
    );
  }
}

class const _ProviderHint({
  required final bool _canAdvance,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.xxs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.s.detailsPexelsAttribution,
              style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ),
          IconButton(
            onPressed: _canAdvance
                ? () => context.read<DetailsBloc>().add(const DetailsStockPageAdvanced())
                : null,
            tooltip: context.s.detailsMorePicturesTooltip,
            icon: const Icon(Icons.find_replace_rounded),
          ),
        ],
      ),
    );
  }
}
