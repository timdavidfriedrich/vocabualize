import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/tag/add_or_update_tag_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/details/domain/use_cases/image/get_draft_image_use_case.dart';
import 'package:vocabualize/src/features/details/domain/use_cases/image/get_stock_images_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/translator/translate_to_english_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/add_or_update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/utils/formatter.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/presentation/states/details_state.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/add_tag_dialog.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/edit_source_target_dialog.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/replace_vocabulary_dialog.dart';
import 'package:vocabualize/src/features/settings/presentation/screens/settings_screen.dart';

final detailsControllerProvider = AutoDisposeAsyncNotifierProviderFamily<DetailsController, DetailsState, Vocabulary>(() {
  return DetailsController();
});

class DetailsController extends AutoDisposeFamilyAsyncNotifier<DetailsState, Vocabulary> {
  @override
  Future<DetailsState> build(Vocabulary arg) async {
    final vocabulary = arg;
    return DetailsState(
      vocabulary: vocabulary,
      stockImages: await _getStockImages(vocabulary),
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
    );
  }

  Future<void> openEditSourceDialog(BuildContext context) async {
    state.value?.let((value) async {
      final Vocabulary? updatedVocabulary = await context.showDialog(
        EditSourceTargetDialog(
          vocabulary: value.vocabulary,
        ),
      );
      if (!context.mounted) return;
      if (updatedVocabulary == null) return;
      if (updatedVocabulary.source == value.vocabulary.source) return;
      bool? hasClickedRetranslate = await context.showDialog(
        const ReplaceVocabularyDialog(),
      );
      if (!context.mounted) return;
      if (hasClickedRetranslate == true) {
        _retranslateAndReload(context, updatedVocabulary);
      } else {
        state = AsyncData(value.copyWith(vocabulary: updatedVocabulary));
      }
    });
  }

  Future<void> _retranslateAndReload(BuildContext context, Vocabulary vocabulary) async {
    final translate = ref.read(translateUseCaseProvider);
    final retranslatedVocabulary = vocabulary.copyWith(
      target: await translate(vocabulary.source),
    );
    if (!context.mounted) return;
    Navigator.popAndPushNamed(
      context,
      DetailsScreen.routeName,
      arguments: DetailsScreenArguments(vocabulary: retranslatedVocabulary),
    );
  }

  Future<void> openEditTargetDialog(BuildContext context) async {
    state.value?.let((value) async {
      final Vocabulary? updatedVocabulary = await context.showDialog(
        EditSourceTargetDialog(
          vocabulary: value.vocabulary,
          editTarget: true,
        ),
      );
      if (!context.mounted) return;
      if (updatedVocabulary == null) return;
      if (updatedVocabulary.target == value.vocabulary.target) return;
      state = AsyncData(value.copyWith(vocabulary: updatedVocabulary));
    });
  }

  Future<List<StockImage>> _getStockImages(Vocabulary vocabulary) async {
    final searchTerm = Formatter.filterOutArticles(
      await ref.read(translateToEnglishUseCaseProvider(vocabulary.source).future),
    );
    return await ref.read(getStockImagesUseCaseProvider(searchTerm).future);
  }

  void browseNext() {
    Log.debug("Test $state");
    state.value?.let((value) {
      Log.debug("Test222");
      if (value.lastStockImageIndex + value.stockImagesPerPage < value.totalStockImages) {
        state = AsyncData(value.copyWith(
          firstStockImageIndex: value.firstStockImageIndex + value.stockImagesPerPage,
          lastStockImageIndex: value.lastStockImageIndex + value.stockImagesPerPage,
        ));
      } else {
        state = AsyncData(value.copyWith(
          firstStockImageIndex: 0,
          lastStockImageIndex: 6,
        ));
      }
    });
  }

  Future<void> getDraftImage() async {
    state.value?.let((value) async {
      final newImage = await ref.read(getDraftImageUseCaseProvider.future);
      if (newImage != null) {
        state = AsyncData(value.copyWith(
          vocabulary: value.vocabulary.copyWith(image: newImage),
        ));
      }
    });
  }

  Future<void> openPhotographerLink() async {
    state.value?.let((value) async {
      final image = value.vocabulary.image;
      if (image is! StockImage) return;
      final photographerUrl = image.photographerUrl;
      if (photographerUrl == null) return;
      await launchUrl(
        Uri.parse(photographerUrl),
        mode: LaunchMode.externalApplication,
      );
    });
  }

  void selectOrUnselectImage(VocabularyImage? image) {
    if (image == null) return;
    state.value?.let((value) {
      final newImage = value.vocabulary.image == image ? const FallbackImage() : image;
      state = AsyncData(
        value.copyWith(
          vocabulary: value.vocabulary.copyWith(image: newImage),
        ),
      );
    });
  }

  Future<void> openCreateTagDialogAndSave(BuildContext context) async {
    state.value?.let((value) async {
      final String? tagName = await context.showDialog(
        const AddTagDialog(),
      );
      if (!context.mounted) return;
      if (tagName == null) return;
      if (tagName.isEmpty) return;
      final addOrUpdateTag = await ref.read(addOrUpdateTagProvider.future);
      final tagId = await addOrUpdateTag(Tag(name: tagName));
      addOrRemoveTag(tagId);
    });
  }

  Future<void> addOrRemoveTag(String? tagId) async {
    if (tagId == null) return;
    state.value?.let((value) {
      final tagIds = value.vocabulary.tagIds;
      final updatedTagIds = switch (tagIds.contains(tagId)) {
        true => tagIds.where((id) => id != tagId).toList(),
        false => [...tagIds, tagId],
      };
      final updatedVocabulary = value.vocabulary.copyWith(tagIds: updatedTagIds);
      state = AsyncData(value.copyWith(vocabulary: updatedVocabulary));
    });
  }

  void deleteVocabulary(BuildContext context) {
    state.value?.let((value) {
      ref.read(deleteVocabularyUseCaseProvider(value.vocabulary));
      Navigator.pop(context);
    });
  }

  void goToSettings(BuildContext context) {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  Future<void> save(BuildContext context) async {
    state.value?.let((value) async {
      await ref.read(addOrUpdateVocabularyUseCaseProvider(value.vocabulary));
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
  }
}
