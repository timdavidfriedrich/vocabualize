import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _overlapFactor = 0.22;

class const PhotoStack({
  super.key,
  required final List<VocabularyImage> _images,
  required final double _size,
  required final Color _borderColor,
  final int _moreCount = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tileCount = _images.length + (_moreCount > 0 ? 1 : 0);
    final step = _size * (1 - _overlapFactor);
    final radius = BorderRadius.circular(_size / 4);
    return SizedBox(
      height: _size,
      width: tileCount == 0 ? 0 : step * (tileCount - 1) + _size,
      child: Stack(
        children: [
          for (final (index, image) in _images.indexed)
            Positioned(
              left: step * index,
              child: _Tile(
                size: _size,
                radius: radius,
                borderColor: _borderColor,
                child: VocabularyImageView(
                  image: image,
                  variant: VocabularyImageVariant.thumbnail,
                  displayWidth: _size,
                ),
              ),
            ),
          if (_moreCount > 0)
            Positioned(
              left: step * _images.length,
              child: _Tile(
                size: _size,
                radius: radius,
                borderColor: _borderColor,
                child: ColoredBox(
                  color: context.c.primaryContainer,
                  child: Center(
                    child: Text(
                      context.s.photoStackMoreLabel(_moreCount.toCountLabel(context)),
                      style: context.t.titleMedium?.copyWith(
                        color: context.c.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class const _Tile({
  required final double _size,
  required final BorderRadius _radius,
  required final Color _borderColor,
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        borderRadius: _radius,
        border: Border.all(color: _borderColor, width: Spacing.borderWidthMedium),
      ),
      child: ClipRRect(
        borderRadius: _radius - BorderRadius.circular(Spacing.borderWidthMedium),
        child: _child,
      ),
    );
  }
}
