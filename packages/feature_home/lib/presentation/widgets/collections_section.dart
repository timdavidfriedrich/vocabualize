import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _cardWidth = Spacing.xxxxl * 2;
const _secondRowThreshold = 8;
const _gridColumns = 2;
const _backgroundOpacity = 0.5;

class const CollectionsSection({
  super.key,
  required final List<CollectionPreview> _collections,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final splitIndex = _collections.length >= _secondRowThreshold
        ? (_collections.length / 2).ceil()
        : _collections.length;
    final firstRow = _collections.sublist(0, splitIndex);
    final secondRow = _collections.sublist(splitIndex);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CollectionRow(collections: firstRow),
          if (secondRow.isNotEmpty) ...[
            const SizedBox(height: Spacing.xs),
            _CollectionRow(collections: secondRow),
          ],
        ],
      ),
    );
  }
}

class const _CollectionRow({
  required final List<CollectionPreview> _collections,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: Spacing.m),
        for (final collection in _collections)
          Padding(
            key: ValueKey(collection.tag.id),
            padding: const EdgeInsets.only(left: Spacing.xs),
            child: _CollectionCard(collection: collection),
          ),
        const SizedBox(width: Spacing.xl),
      ],
    );
  }
}

class const _CollectionCard({
  required final CollectionPreview _collection,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = _collection.images;
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
      color: context.c.surfaceContainerLow,
      onPressed: () => context.pushCollection(tagId: _collection.tag.id),
      padding: const EdgeInsets.all(Spacing.xs),
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: _cardWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Spacing.radiusM),
              child: ColoredBox(
                color: context.c.surfaceContainerLow.withValues(alpha: _backgroundOpacity),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: images.length == 1 ? 1 : _gridColumns,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) => VocabularyImageView(
                    image: images[index],
                    variant: VocabularyImageVariant.thumbnail,
                    displayWidth: _cardWidth / _gridColumns,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Container(
            width: _cardWidth,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
            child: Text(_collection.tag.name, style: context.t.bodyLarge),
          ),
        ],
      ),
    );
  }
}
