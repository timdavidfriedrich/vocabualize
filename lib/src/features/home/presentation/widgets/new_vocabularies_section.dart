import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extensions.dart';
import 'package:vocabualize/src/features/home/presentation/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';

class NewVocabulariesSection extends ConsumerWidget {
  final HomeState state;
  final Refreshable<HomeController> notifier;
  const NewVocabulariesSection({
    required this.state,
    required this.notifier,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: Dimensions.mediumSpacing),
          for (final vocabulary in state.newVocabularies) ...[
            const SizedBox(width: Dimensions.smallSpacing),
            _NewVocabularyCard(
              state: state,
              notifier: notifier,
              vocabulary: vocabulary,
            ),
          ],
          const SizedBox(width: Dimensions.semiLargeSpacing),
        ],
      ),
    );
  }
}

class _NewVocabularyCard extends ConsumerWidget {
  final HomeState state;
  final Refreshable<HomeController> notifier;
  final Vocabulary vocabulary;

  const _NewVocabularyCard({
    required this.state,
    required this.notifier,
    required this.vocabulary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const cardSpacing = 128.0;
    return MaterialButton(
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: state.areImagesEnabled
          ? const EdgeInsets.all(Dimensions.smallSpacing)
          : const EdgeInsets.all(Dimensions.mediumSpacing),
      color:
          state.areImagesEnabled ? null : Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
        side: state.areImagesEnabled
            ? BorderSide.none
            : BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: Dimensions.mediumBorderWidth,
              ),
      ),
      onPressed: () {
        ref.read(notifier).showVocabularyInfo(context, vocabulary);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.areImagesEnabled) ...[
            _ImageBox(
              state: state,
              cardSpacing: cardSpacing,
              vocabulary: vocabulary,
            ),
            const SizedBox(height: Dimensions.smallSpacing),
          ],
          _LabelContainer(
            state: state,
            cardSpacing: cardSpacing,
            label: vocabulary.target,
          ),
          _LabelContainer(
            state: state,
            cardSpacing: cardSpacing,
            label: vocabulary.source,
            textColor: Theme.of(context).hintColor,
          ),
        ],
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  final HomeState state;
  final double cardSpacing;
  final Vocabulary vocabulary;
  const _ImageBox({
    required this.state,
    required this.cardSpacing,
    required this.vocabulary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardSpacing,
      height: cardSpacing,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.mediumBorderRadius),
        child: vocabulary.image.getImage(
          fit: BoxFit.cover,
          size: ImageSize.medium,
        ),
      ),
    );
  }
}

class _LabelContainer extends StatelessWidget {
  final HomeState state;
  final double cardSpacing;
  final String label;
  final Color? textColor;
  const _LabelContainer({
    required this.state,
    required this.cardSpacing,
    required this.label,
    this.textColor,
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
        textAlign: state.areImagesEnabled ? TextAlign.start : TextAlign.center,
      ),
    );
  }
}
