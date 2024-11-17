import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/home/presentation/controllers/home_controller.dart';

class TagCardButton extends ConsumerWidget {
  final bool areImagesEnabled;
  final Tag tag;
  final List<Vocabulary> tagVocabularies;

  const TagCardButton({
    required this.areImagesEnabled,
    required this.tag,
    required this.tagVocabularies,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surface,
      onPressed: () {
        ref.read(homeControllerProvider.notifier).goToCollection(context, tag);
      },
      padding: areImagesEnabled ? const EdgeInsets.all(8.0) : const EdgeInsets.all(16.0),
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: _buildContent(
          context: context,
          areImagesEnabled: areImagesEnabled,
          tagVocabularies: tagVocabularies,
        ),
      ),
    );
  }

  List<Widget> _buildContent({
    required BuildContext context,
    required bool areImagesEnabled,
    required List<Vocabulary> tagVocabularies,
  }) {
    if (tagVocabularies.isEmpty) {
      return [
        Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.onSurface,
        )
      ];
    }
    return [
      if (areImagesEnabled)
        SizedBox(
          width: 128,
          height: 128,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
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
                  return Image(
                    image: NetworkImage(
                      tagVocabularies.elementAt(index).image.url,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      if (areImagesEnabled) const SizedBox(height: 8),
      SizedBox(
        width: 128,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            tag.name,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: areImagesEnabled ? TextAlign.start : TextAlign.center,
          ),
        ),
      ),
    ];
  }
}
