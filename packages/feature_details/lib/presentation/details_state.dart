import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'details_state.mapper.dart';

const stockImagesPerPage = 7;

@MappableEnum()
enum DetailsPendingLookup { translationAndPhotos, translations, photos }

@MappableEnum()
enum DetailsNotice { translationReported }

@MappableEnum()
enum DetailsAction { lookup, photoPick, report, tagCreation, save, delete }

@MappableClass()
sealed class DetailsState with DetailsStateMappable {
  const DetailsState();
}

@MappableClass()
class const DetailsLoading() extends DetailsState with DetailsLoadingMappable;

@MappableClass()
class const DetailsDuplicateFound({
  required final String text,
  required final Language language,
  required final ProcessedImage? photo,
  required final String? context,
}) extends DetailsState with DetailsDuplicateFoundMappable;

@MappableClass()
class const DetailsExistingFound({
  required final String text,
  required final Vocabulary vocabulary,
  required final Language language,
  required final Language knownLanguage,
}) extends DetailsState with DetailsExistingFoundMappable;

@MappableClass()
class const DetailsText({
  required final String text,
  required final TranslationOrigin origin,
}) with DetailsTextMappable;

@MappableClass()
class const DetailsEditing({
  required final Vocabulary? original,
  required final LanguageSetup setup,
  required final Language enteredLanguage,
  required final Map<Language, DetailsText> texts,
  required final Set<Language> enabledLanguages,
  required final Set<Language> translatingLanguages,
  required final String? context,
  required final DetailsImage selectedImage,
  required final DetailsImage? ownPhoto,
  required final List<StockImage> stockImages,
  required final int stockPage,
  required final List<Tag> tags,
  required final Set<String> selectedTagIds,
  required final DetailsPendingLookup? pendingLookup,
  required final bool isSearchingPhotos,
  required final DetailsAction? runningAction,
  required final DetailsNotice? notice,
  required final AppError? error,
}) extends DetailsState with DetailsEditingMappable;

extension DetailsEditingExtensions on DetailsEditing {
  String textOf(Language language) => texts[language]?.text ?? "";

  String get enteredText => textOf(enteredLanguage);

  List<Language> get activeLanguages => [
    for (final learned in setup.active) learned.language,
  ];

  List<Language> get askMeInLanguages => {
    for (final learned in setup.learned)
      if (learned.askMeIn case final askMeIn?
          when askMeIn != setup.main && !setup.isLearning(askMeIn))
        askMeIn,
  }.toList();

  List<Language> get pausedLanguages => [
    for (final learned in setup.paused) learned.language,
  ];

  bool get isSingleLayout =>
      activeLanguages.length == 1 && askMeInLanguages.isEmpty && pausedLanguages.isEmpty;

  Set<Language> get shownLanguages => {
    setup.main,
    ...activeLanguages,
    ...askMeInLanguages,
  };

  Set<Language> get missingLanguages => {
    for (final language in {...shownLanguages, ...enabledLanguages})
      if (language != enteredLanguage && textOf(language).isEmpty) language,
  };

  bool get canSave =>
      enteredText.isNotEmpty &&
      enabledLanguages.isNotEmpty &&
      activeLanguages.every(
        (language) => !enabledLanguages.contains(language) || textOf(language).isNotEmpty,
      );

  bool canSwitchOff(Language language) =>
      !enabledLanguages.contains(language) || enabledLanguages.length > 1;
}

@MappableClass()
class const DetailsAdded() extends DetailsState with DetailsAddedMappable;

@MappableClass()
class const DetailsClosed() extends DetailsState with DetailsClosedMappable;

@MappableClass()
class const DetailsFailure({
  required final AppError error,
}) extends DetailsState with DetailsFailureMappable;

@MappableClass()
sealed class DetailsImage with DetailsImageMappable {
  const DetailsImage();
}

@MappableClass()
class const DetailsNoImage() extends DetailsImage with DetailsNoImageMappable;

@MappableClass()
class const DetailsNewPhoto({
  required final ProcessedImage image,
}) extends DetailsImage with DetailsNewPhotoMappable;

@MappableClass()
class const DetailsStockPhoto({
  required final StockImage image,
}) extends DetailsImage with DetailsStockPhotoMappable;

@MappableClass()
class const DetailsSavedImage({
  required final VocabularyImage image,
}) extends DetailsImage with DetailsSavedImageMappable;
