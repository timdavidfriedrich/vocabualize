import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

part 'details_state.mapper.dart';

const stockImagesPerPage = 7;

@MappableEnum()
enum DetailsPendingLookup { translationAndPhotos, photos }

@MappableEnum()
enum DetailsNotice { translationReported }

@MappableClass()
sealed class DetailsState with DetailsStateMappable {
  const DetailsState();
}

@MappableClass()
class const DetailsLoading() extends DetailsState with DetailsLoadingMappable;

@MappableClass()
class const DetailsDuplicateFound({
  required final String source,
  required final ProcessedImage? photo,
}) extends DetailsState with DetailsDuplicateFoundMappable;

@MappableClass()
class const DetailsEditing({
  required final Vocabulary? original,
  required final LanguagePair? languages,
  required final String source,
  required final String target,
  required final DetailsImage selectedImage,
  required final DetailsImage? ownPhoto,
  required final List<StockImage> stockImages,
  required final int stockPage,
  required final List<Tag> tags,
  required final Set<String> selectedTagIds,
  required final DetailsPendingLookup? pendingLookup,
  required final bool isBusy,
  required final DetailsNotice? notice,
  required final AppError? error,
}) extends DetailsState with DetailsEditingMappable;

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
