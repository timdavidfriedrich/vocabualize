import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/widgets/vocabulary_image_view.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

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
    return MaterialButton(
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.all(Spacing.xs),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
      onPressed: _onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          _Label(text: _vocabulary.target),
          _Label(text: _vocabulary.source, color: context.c.outline),
        ],
      ),
    );
  }
}

class const _Label({
  required final String _text,
  final Color? _color,
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
        textAlign: TextAlign.start,
      ),
    );
  }
}
