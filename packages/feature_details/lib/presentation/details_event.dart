import 'package:feature_details/presentation/details_state.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/domain/entities/processed_image.dart';

sealed class DetailsEvent {
  const DetailsEvent();
}

class const DetailsNewStarted({
  required final String source,
  required final ProcessedImage? photo,
}) extends DetailsEvent;

class const DetailsEditStarted({
  required final String vocabularyId,
}) extends DetailsEvent;

class const DetailsConnectionRestored() extends DetailsEvent;

class const DetailsDuplicateResolved({
  required final bool addsAnyway,
}) extends DetailsEvent;

class const DetailsSourceChanged({
  required final String source,
  required final bool retranslates,
}) extends DetailsEvent;

class const DetailsTargetChanged({
  required final String target,
}) extends DetailsEvent;

class const DetailsPhotoPickRequested({
  required final ImagePickSource source,
}) extends DetailsEvent;

class const DetailsImageToggled({
  required final DetailsImage image,
}) extends DetailsEvent;

class const DetailsStockPageAdvanced() extends DetailsEvent;

class const DetailsTagToggled({
  required final String tagId,
}) extends DetailsEvent;

class const DetailsTagCreated({
  required final String name,
}) extends DetailsEvent;

class const DetailsPhotographerLinkOpened() extends DetailsEvent;

class const DetailsSaveRequested() extends DetailsEvent;

class const DetailsDeleteRequested() extends DetailsEvent;
