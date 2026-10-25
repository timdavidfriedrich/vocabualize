import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/widgets/vocabulary_image_view.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

class const VocabularyThumbnail({
  super.key,
  required final VocabularyImage _image,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: Spacing.xxxl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Spacing.radiusM),
        child: VocabularyImageView(
          image: _image,
          variant: VocabularyImageVariant.thumbnail,
          displayWidth: Spacing.xxxl,
        ),
      ),
    );
  }
}
