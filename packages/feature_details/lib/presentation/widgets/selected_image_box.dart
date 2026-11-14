import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_context_extensions.dart';
import 'package:feature_details/presentation/extensions/details_image_extensions.dart';
import 'package:feature_details/presentation/widgets/empty_image_box.dart';
import 'package:feature_details/presentation/widgets/image_choice.dart';
import 'package:feature_details/presentation/widgets/image_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/photo_overlay.dart';

class const SelectedImageBox({
  super.key,
  required final ImageChoice _choice,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = _choice.selected;
    final provider = selected.toImageProvider(isThumbnail: false);
    if (_choice.isLoadingImage) {
      return const ImageFrame(child: Center(child: CircularProgressIndicator()));
    }
    if (provider == null) return EmptyImageBox(choice: _choice);
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
          onPressed: _choice.isBusy ? null : context.pickPhoto,
        ),
      },
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
