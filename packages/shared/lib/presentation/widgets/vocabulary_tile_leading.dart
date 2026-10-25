import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/widgets/level_indicator.dart';
import 'package:shared/presentation/widgets/vocabulary_thumbnail.dart';

class const VocabularyTileLeading({
  super.key,
  required final Vocabulary _vocabulary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LevelIndicator(
          level: _vocabulary.level.toVocabularyLevel(),
          margin: const EdgeInsets.symmetric(vertical: Spacing.xs),
        ),
        const SizedBox(width: Spacing.s),
        VocabularyThumbnail(image: _vocabulary.image),
      ],
    );
  }
}
