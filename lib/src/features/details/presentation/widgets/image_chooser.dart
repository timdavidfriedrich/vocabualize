import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/constants/image_constants.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extensions.dart';
import 'package:vocabualize/src/features/details/presentation/controllers/details_controller.dart';
import 'package:vocabualize/src/features/details/presentation/states/details_state.dart';

class ImageChooser extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  final DetailsState state;
  const ImageChooser({
    required this.notifier,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
              border: Border.all(
                width: Dimensions.mediumBorderWidth,
                color: Theme.of(context).colorScheme.primary,
              ),
              color: Theme.of(context).colorScheme.surface,
              image: state.vocabulary.image is FallbackImage
                  ? null
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: state.vocabulary.image.getImageProvider(),
                    ),
            ),
            child: state.vocabulary.image is FallbackImage
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)?.record_addDetails_noImage ?? "",
                      textAlign: TextAlign.center,
                    ),
                  )
                : state.vocabulary.image is StockImage
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          backgroundBlendMode: BlendMode.darken,
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter / 12,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            onPressed: () {
                              ref.read(notifier).openPhotographerLink();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: Dimensions.smallSpacing),
                                Flexible(
                                  child: Text(
                                    // TODO: Replace with arb
                                    "Photo by ${(state.vocabulary.image as StockImage).photographer}",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.smallSpacing),
                                Icon(
                                  Icons.launch_rounded,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: Dimensions.smallSpacing),
                              ],
                            ),
                          ),
                        ),
                      )
                    : null,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)?.record_addDetails_providedBy ?? "", style: Theme.of(context).textTheme.bodySmall),
            IconButton(
              onPressed: () {
                ref.read(notifier).browseNext();
              },
              icon: const Icon(Icons.find_replace_rounded),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: state.stockImagesPerPage + 1,
          itemBuilder: (context, index) => index == 0
              ? _CustomImageButton(notifier: notifier, state: state)
              : _StockImageButton(
                  notifier: notifier,
                  state: state,
                  index: index - 1,
                ),
        ),
      ],
    );
  }
}

class _CustomImageButton extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  final DetailsState state;
  const _CustomImageButton({
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      elevation: 0,
      onPressed: () {
        ref.read(notifier).getDraftImage(context);
      },
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
      ),
      child: state.vocabulary.image is DraftImage
          ? Ink(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
                border: Border.all(
                  width: Dimensions.mediumBorderWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: state.vocabulary.image.getImageProvider(),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.done_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            )
          : Icon(
              Icons.camera_alt_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
    );
  }
}

class _StockImageButton extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  final DetailsState state;
  final int index;
  const _StockImageButton({
    required this.notifier,
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: state.stockImages.isEmpty
          ? null
          : () {
              ref.read(notifier).selectOrUnselectImage(
                    state.stockImages.elementAt(index + state.firstStockImageIndex),
                  );
            },
      borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
      child: state.firstStockImageIndex + index >= state.stockImages.length
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
                border: state.stockImages.elementAt(index + state.firstStockImageIndex) != state.vocabulary.image
                    ? null
                    : Border.all(
                        width: Dimensions.mediumBorderWidth,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    state.stockImages.elementAt(index + state.firstStockImageIndex).sizeVariants?["small"] ??
                        ImageConstants.fallbackImageUrl,
                  ),
                ),
              ),
              child: state.stockImages.elementAt(index + state.firstStockImageIndex) != state.vocabulary.image
                  ? null
                  : Center(
                      child: Icon(
                        Icons.done_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
            ),
    );
  }
}
