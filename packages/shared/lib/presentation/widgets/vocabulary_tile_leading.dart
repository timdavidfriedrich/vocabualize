import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/vocabulary_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/level_indicator.dart';
import 'package:shared/presentation/widgets/vocabulary_thumbnail.dart';

class const VocabularyTileLeading({
  super.key,
  required final Vocabulary _vocabulary,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LevelIndicator(
          level: _vocabulary.levelOf(_language),
          margin: const EdgeInsets.symmetric(vertical: Spacing.xs),
        ),
        BlocSelector<PreferencesCubit, Preferences, bool>(
          selector: (preferences) => preferences.areImagesHidden,
          builder: (context, areImagesHidden) => switch (areImagesHidden) {
            true => const SizedBox.shrink(),
            false => Padding(
              padding: const EdgeInsets.only(left: Spacing.s),
              child: VocabularyThumbnail(image: _vocabulary.image),
            ),
          },
        ),
      ],
    );
  }
}
