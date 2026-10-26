import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _cardWidth = Spacing.xxxxl * 2;

class const RecentVocabulariesSection({
  super.key,
  required final List<Vocabulary> _vocabularies,
  required final ValueChanged<Vocabulary> _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: Spacing.m),
          for (final vocabulary in _vocabularies) ...[
            const SizedBox(width: Spacing.xs),
            _RecentVocabularyCard(
              key: ValueKey(vocabulary.id),
              vocabulary: vocabulary,
              onTap: () => _onTap(vocabulary),
            ),
          ],
          const SizedBox(width: Spacing.xl),
        ],
      ),
    );
  }
}

class const _RecentVocabularyCard({
  super.key,
  required final Vocabulary _vocabulary,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PreferencesCubit, Preferences, bool>(
      selector: (preferences) => preferences.areImagesHidden,
      builder: (context, areImagesHidden) => MaterialButton(
        elevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        padding: EdgeInsets.all(areImagesHidden ? Spacing.m : Spacing.xs),
        color: areImagesHidden ? context.c.surfaceContainerLow : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusL),
          side: areImagesHidden
              ? BorderSide(color: context.c.primary, width: Spacing.borderWidthMedium)
              : BorderSide.none,
        ),
        onPressed: _onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!areImagesHidden) ...[
              SizedBox.square(
                dimension: _cardWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.radiusL),
                  child: VocabularyImageView(
                    image: _vocabulary.image,
                    variant: VocabularyImageVariant.full,
                    displayWidth: _cardWidth,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.xs),
            ],
            _Label(text: _vocabulary.target, isCentered: areImagesHidden),
            _Label(
              text: _vocabulary.source,
              color: context.c.outline,
              isCentered: areImagesHidden,
            ),
          ],
        ),
      ),
    );
  }
}

class const _Label({
  required final String _text,
  final Color? _color,
  final bool _isCentered = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _cardWidth,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
      child: Text(
        _text,
        style: context.t.bodyLarge?.copyWith(color: _color),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: _isCentered ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
