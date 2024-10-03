import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/home/widgets/info_dialog.dart';

class NewVocabularyCard extends ConsumerWidget {
  final Vocabulary vocabulary;

  const NewVocabularyCard({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAreImagesEnabled = ref.watch(getAreImagesEnabledUseCaseProvider);

    return getAreImagesEnabled.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (error, stackTrace) {
        // TODO: Replace with error widget
        return const Text("Error NewVocabularyCard");
      },
      data: (bool areImagesEnabled) {
        return MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: areImagesEnabled ? BorderSide.none : BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)),
          color: areImagesEnabled ? null : Theme.of(context).colorScheme.surface,
          onPressed: () => Navigator.pushNamed(context, DetailsScreen.routeName, arguments: DetailsScreenArguments(vocabulary: vocabulary)),
          onLongPress: () => HelperWidgets.showStaticDialog(InfoDialog(vocabulary: vocabulary)),
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
            children: [
              if (areImagesEnabled)
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
              if (areImagesEnabled) const SizedBox(height: 8),
              SizedBox(
                width: 128,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    vocabulary.target,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: areImagesEnabled ? TextAlign.start : TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 128,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    vocabulary.source,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor),
                    textAlign: areImagesEnabled ? TextAlign.start : TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
