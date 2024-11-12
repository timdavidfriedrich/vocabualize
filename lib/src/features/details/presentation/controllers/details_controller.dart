import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/features/details/domain/usecases/image/get_draft_image_use_case.dart';
import 'package:vocabualize/src/features/details/domain/usecases/image/get_stock_images_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_are_images_enabled_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_to_english_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/add_or_update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/utils/formatter.dart';
import 'package:vocabualize/src/features/details/presentation/states/details_state.dart';
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

  Future<List<StockImage>> _getStockImages(Vocabulary vocabulary) async {
    final searchTerm = Formatter.filterOutArticles(
      await ref.read(translateToEnglishUseCaseProvider(vocabulary.source).future),
    );
    return await ref.read(getStockImagesUseCaseProvider(searchTerm).future);
  }

  void browseNext() {
    state.whenData((value) {
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
    state.whenData((value) async {
      // TODO: Is loading necessary then getting a draft image?
      state = const AsyncLoading();
      final newImage = await ref.read(getDraftImageUseCaseProvider.future);
      if (newImage != null) {
        state = AsyncData(value.copyWith(
          vocabulary: value.vocabulary.copyWith(image: newImage),
        ));
      }
    });
  }

  Future<void> openPhotographerLink() async {
    state.whenData((value) async {
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
    state.whenData((value) {
      final newImage = value.vocabulary.image == image ? const FallbackImage() : image;
      state = AsyncData(
        value.copyWith(
          vocabulary: value.vocabulary.copyWith(image: newImage),
        ),
      );
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
      await ref.read(addOrUpdateVocabularyUseCaseProvider(value.vocabulary));
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
  }
}
