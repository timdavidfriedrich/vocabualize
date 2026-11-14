import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_context_extensions.dart';
import 'package:feature_details/presentation/extensions/details_image_extensions.dart';
import 'package:feature_details/presentation/widgets/image_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _selectedInset = Spacing.borderWidthThick + Spacing.borderWidthMedium;

class const OwnPhotoTile({
  super.key,
  required final ImageChoice _choice,
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
          onTap: _choice.isBusy ? null : context.pickPhoto,
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
        (false, true) => context.pickPhoto,
        (false, false) => () => context.read<DetailsBloc>().add(
          DetailsImageToggled(image: ownPhoto),
        ),
      },
      onRemoved: null,
    );
  }
}

class const StockImageTile({
  super.key,
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
