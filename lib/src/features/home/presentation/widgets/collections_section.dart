import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extensions.dart';
import 'package:vocabualize/src/features/home/presentation/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/presentation/extentions/list_extensions.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';

class CollectionsSection extends StatelessWidget {
  final HomeState state;
  final Refreshable<HomeController> notifier;
  const CollectionsSection({
    required this.state,
    required this.notifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int threshold = 8;
    final List<Tag> firstTags;
    final List<Tag> secondTags;
    (firstTags, secondTags) = state.tags.splitListInHalf(threshold: threshold);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SingleCollectionRow(
            state: state,
            notifier: notifier,
            tags: firstTags,
          ),
          if (secondTags.isNotEmpty) ...[
            const SizedBox(height: Dimensions.smallSpacing),
            _SingleCollectionRow(
              state: state,
              notifier: notifier,
              tags: secondTags,
            ),
          ],
        ],
      ),
    );
  }
}

class _SingleCollectionRow extends StatelessWidget {
  final HomeState state;
  final Refreshable<HomeController> notifier;
  final List<Tag> tags;
  const _SingleCollectionRow({
    required this.state,
    required this.notifier,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: Dimensions.mediumSpacing),
        for (final tag in tags) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.smallSpacing,
            ),
            child: _CollectionCardButton(
              state: state,
              notifier: notifier,
              tag: tag,
              tagVocabularies: state.vocabularies.where((element) {
                return element.tagIds.contains(tag.id);
              }).toList(),
            ),
          ),
        ],
        const SizedBox(width: Dimensions.semiLargeSpacing),
      ],
    );
  }
}

class _CollectionCardButton extends ConsumerWidget {
  final HomeState state;
  final Refreshable<HomeController> notifier;
  final Tag tag;
  final List<Vocabulary> tagVocabularies;

  const _CollectionCardButton({
    required this.state,
    required this.notifier,
    required this.tag,
    required this.tagVocabularies,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const cardSpacing = 128.0;
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
      ),
      color: Theme.of(context).colorScheme.surface,
      onPressed: () {
        ref.read(notifier).goToCollection(context, tag);
      },
      padding: state.areImagesEnabled
          ? const EdgeInsets.all(Dimensions.smallSpacing)
          : const EdgeInsets.all(Dimensions.mediumSpacing),
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.areImagesEnabled) ...[
            _ImageBox(
              state: state,
              cardSpacing: cardSpacing,
              tagVocabularies: tagVocabularies,
            ),
            const SizedBox(height: Dimensions.smallSpacing),
          ],
          _LabelContainer(
            state: state,
            cardSpacing: cardSpacing,
            label: tag.name,
          ),
        ],
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  final HomeState state;
  final double cardSpacing;
  final List<Vocabulary> tagVocabularies;
  const _ImageBox({
    required this.state,
    required this.cardSpacing,
    required this.tagVocabularies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardSpacing,
      height: cardSpacing,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.semiSmallBorderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: min(tagVocabularies.length, 2),
            ),
            itemCount: min(tagVocabularies.length, 4),
            itemBuilder: (context, index) {
              final vocabulary = tagVocabularies.reversed.elementAt(index);
              return Image(
                fit: BoxFit.cover,
                image: vocabulary.image.getImageProvider(size: ImageSize.small),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LabelContainer extends StatelessWidget {
  final HomeState state;
  final double cardSpacing;
  final String label;
  const _LabelContainer({
    required this.state,
    required this.cardSpacing,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardSpacing,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.extraSmallSpacing,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: state.areImagesEnabled ? TextAlign.start : TextAlign.center,
      ),
    );
  }
}
