import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/processed_image.dart';

part 'details_state.mapper.dart';

@MappableClass()
sealed class DetailsState with DetailsStateMappable {
  const DetailsState();
}

@MappableClass()
class const DetailsEditing({
  required final ProcessedImage? image,
  required final bool isBusy,
  required final AppError? error,
}) extends DetailsState with DetailsEditingMappable;

@MappableClass()
class const DetailsSaved() extends DetailsState with DetailsSavedMappable;
