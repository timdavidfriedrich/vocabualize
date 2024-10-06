import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/usecases/image/get_draft_image_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/image/get_stock_images_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/image/upload_image_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_to_english_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/add_or_update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/utils/formatter.dart';
import 'package:vocabualize/src/features/details/states/details_state.dart';
import 'package:vocabualize/src/features/settings/screens/settings_screen.dart';

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
      selectedImage: vocabulary.image is FallbackImage ? null : vocabulary.image,
      areImagesEnabled: await ref.watch(getAreImagesEnabledUseCaseProvider.future),
    );
  }

  Future<List<StockImage>> _getStockImages(Vocabulary vocabulary) async {
    final searchTerm = Formatter.filterOutArticles(
      await ref.read(translateToEnglishUseCaseProvider(vocabulary.source).future),
    );
    return await ref.read(getStockImagesUseCaseProvider(searchTerm).future);
  }

  void browseNext() {
    state.whenData((value) {
      final nextFirstIndex = value.firstStockImageIndex - value.stockImagesPerPage;
      final nextLastIndex = value.lastStockImageIndex + value.stockImagesPerPage;
      if (nextLastIndex < value.totalStockImages) {
        state = AsyncData(value.copyWith(
          firstStockImageIndex: nextFirstIndex,
          lastStockImageIndex: nextLastIndex,
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
    state.whenData((value) async {
      // TODO: Is loading necessary then getting a draft image?
      state = const AsyncLoading();
      final image = await ref.read(getDraftImageUseCaseProvider.future);
      if (image != null) {
        state = AsyncData(value.copyWith(selectedImage: image));
      }
    });
  }

  Future<void> openPhotographerLink() async {
    state.whenData((value) async {
      final imageUrl = value.selectedImage?.url;
      if (imageUrl == null) return;
      await launchUrl(
        Uri.parse(imageUrl),
        mode: LaunchMode.externalApplication,
      );
    });
  }

  void selectOrUnselectImage(VocabularyImage? image) {
    if (image == null) return;
    state.whenData((value) {
      if (value.selectedImage == image) {
        state = AsyncData(value.copyWith(selectedImage: null));
      } else {
        state = AsyncData(value.copyWith(selectedImage: image));
      }
    });
  }

  void deleteVocabulary(BuildContext context) {
    state.whenData((value) {
      ref.read(deleteVocabularyUseCaseProvider(value.vocabulary));
      Navigator.pop(context);
    });
  }

  void goToSettings(BuildContext context) {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  Future<void> save(BuildContext context) async {
    state.whenData((value) async {
      final selectedImage = value.selectedImage;
      if (selectedImage != null) {
        ref.read(uploadImageUseCaseProvider(selectedImage));
      }
      final updatedVocabulary = value.vocabulary.copyWith(image: value.selectedImage);
      await ref.read(addOrUpdateVocabularyUseCaseProvider(updatedVocabulary));
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
  }
}
