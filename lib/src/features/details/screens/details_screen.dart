import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/constants/image_constants.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extentions.dart';
import 'package:vocabualize/src/features/details/controllers/details_controller.dart';
import 'package:vocabualize/src/features/details/screens/details_disabled_images_screen.dart';
import 'package:vocabualize/src/features/details/states/details_state.dart';
import 'package:vocabualize/src/features/details/widgets/source_to_target.dart';
import 'package:vocabualize/src/features/details/widgets/tag_wrap.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';

// TODO: Refactor DetailsScreen. Especially only save vocabulary on 'Save'. Perhaps, even translate the vocabulary here

class DetailsScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/AddDetails";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Vocabulary vocabulary = Vocabulary();
    DetailsScreenArguments? arguments = ModalRoute.of(context)?.settings.arguments as DetailsScreenArguments?;
    if (arguments != null) {
      vocabulary = arguments.vocabulary;
    }

    final asyncState = ref.watch(detailsControllerProvider(vocabulary));
    return asyncState.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (error, stackTrace) {
        // TODO: Replace with error widget
        return const Text("Error DetailsScreen");
      },
      data: (DetailsState state) {
        if (!state.areImagesEnabled) {
          const DetailsDisabledImagesScreen();
        }
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: vocabulary.source.isEmpty
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(48, 0, 48, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const SizedBox(height: 24),
                                SourceToTarget(vocabulary: vocabulary),
                                const SizedBox(height: 12),
                                AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                      color: Theme.of(context).colorScheme.surface,
                                      image: state.vocabulary.image is FallbackImage
                                          ? null
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: state.vocabulary.image.getImageProvider(),
                                            ),
                                    ),
                                    child: state.vocabulary.image is FallbackImage
                                        ? Center(
                                            child: Text(
                                              AppLocalizations.of(context)?.record_addDetails_noImage ?? "",
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : state.vocabulary.image is StockImage
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    backgroundBlendMode: BlendMode.darken,
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomCenter,
                                                        end: Alignment.topCenter / 12,
                                                        colors: [Colors.black.withOpacity(0.5), Colors.transparent])),
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      ref.read(detailsControllerProvider(vocabulary).notifier).openPhotographerLink();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(width: 8),
                                                        Flexible(
                                                          child: Text(
                                                            // TODO: Replace with arb
                                                            "Photo by ${(state.vocabulary.image as StockImage).photographer}",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Icon(
                                                          Icons.launch_rounded,
                                                          size: 18,
                                                          color: Theme.of(context).colorScheme.onPrimary,
                                                        ),
                                                        const SizedBox(width: 8),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppLocalizations.of(context)?.record_addDetails_providedBy ?? "",
                                        style: Theme.of(context).textTheme.bodySmall),
                                    IconButton(
                                      onPressed: () {
                                        ref.read(detailsControllerProvider(vocabulary).notifier).browseNext();
                                      },
                                      icon: const Icon(Icons.find_replace_rounded),
                                    ),
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                  ),
                                  itemCount: state.stockImagesPerPage + 1,
                                  itemBuilder: (context, index) => index == 0
                                      ? MaterialButton(
                                          padding: EdgeInsets.zero,
                                          elevation: 0,
                                          onPressed: () {
                                            ref.read(detailsControllerProvider(vocabulary).notifier).getDraftImage();
                                          },
                                          color: Theme.of(context).colorScheme.surface,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                          child: state.selectedImage is DraftImage
                                              ? Ink(
                                                  padding: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16),
                                                    border: Border.all(
                                                      width: 2,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: state.selectedImage!.getImageProvider(),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.done_rounded,
                                                      color: Theme.of(context).colorScheme.onSurface,
                                                    ),
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Theme.of(context).colorScheme.primary,
                                                  size: 28,
                                                ),
                                        )
                                      : InkWell(
                                          onTap: state.stockImages.isEmpty
                                              ? null
                                              : () {
                                                  ref.read(detailsControllerProvider(vocabulary).notifier).selectOrUnselectImage(
                                                        state.stockImages.elementAt(index + state.firstStockImageIndex - 1),
                                                      );
                                                },
                                          borderRadius: BorderRadius.circular(16),
                                          child: state.firstStockImageIndex + index >= state.stockImages.length + 1
                                              ? const Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator.adaptive())
                                              : Ink(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16),
                                                    border: state.stockImages.elementAt(index + state.firstStockImageIndex - 1) !=
                                                            state.selectedImage
                                                        ? null
                                                        : Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        state.stockImages
                                                                .elementAt(index + state.firstStockImageIndex - 1)
                                                                .sizeVariants?["small"] ??
                                                            ImageConstants.fallbackImageUrl,
                                                      ),
                                                    ),
                                                  ),
                                                  child: state.stockImages.elementAt(index + state.firstStockImageIndex - 1) !=
                                                          state.selectedImage
                                                      ? null
                                                      : Center(
                                                          child: Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.onSurface),
                                                        ),
                                                ),
                                        ),
                                ),
                                const SizedBox(height: 16),
                                TagWrap(vocabulary: vocabulary),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                  backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                                  foregroundColor: Theme.of(context).colorScheme.error,
                                ),
                                onPressed: () {
                                  ref.read(deleteVocabularyUseCaseProvider(vocabulary));
                                },
                                child: const Icon(Icons.delete_rounded),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    ref.read(detailsControllerProvider(vocabulary).notifier).save(context);
                                  },
                                  child: Text(
                                    state.selectedImage == null
                                        ? AppLocalizations.of(context)?.record_addDetails_saveWithoutButton ?? ""
                                        : AppLocalizations.of(context)?.record_addDetails_saveButton ?? "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              ref.read(detailsControllerProvider(vocabulary).notifier).goToSettings(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)?.record_addDetails_neverAskForImageButton ?? "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
