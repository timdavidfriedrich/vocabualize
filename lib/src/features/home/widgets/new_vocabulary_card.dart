import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/home/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/states/home_state.dart';

class NewVocabularyCard extends ConsumerWidget {
  final HomeState state;
  final Vocabulary vocabulary;

  const NewVocabularyCard({
    required this.state,
    required this.vocabulary,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: state.areImagesEnabled
            ? BorderSide.none
            : BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
      ),
      color: state.areImagesEnabled ? null : Theme.of(context).colorScheme.surface,
      onPressed: () {
        ref.read(homeControllerProvider.notifier).goToDetails(context, vocabulary);
      },
      onLongPress: () {
        ref.read(homeControllerProvider.notifier).showVocabularyInfo(vocabulary);
      },
      padding: state.areImagesEnabled ? const EdgeInsets.all(8.0) : const EdgeInsets.all(16.0),
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
          if (state.areImagesEnabled)
            SizedBox(
              width: 128,
              height: 128,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage(
                    vocabulary.image.url,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (state.areImagesEnabled) const SizedBox(height: 8),
          SizedBox(
            width: 128,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                vocabulary.target,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: state.areImagesEnabled ? TextAlign.start : TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 128,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                vocabulary.source,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                textAlign: state.areImagesEnabled ? TextAlign.start : TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
