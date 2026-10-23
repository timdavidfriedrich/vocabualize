import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'details_state.mapper.dart';

@MappableClass()
sealed class DetailsState with DetailsStateMappable {
  const DetailsState();
}

@MappableClass()
class const DetailsEditing() extends DetailsState with DetailsEditingMappable;

@MappableClass()
class const DetailsSaving() extends DetailsState with DetailsSavingMappable;

@MappableClass()
class const DetailsSaved() extends DetailsState with DetailsSavedMappable;

@MappableClass()
class const DetailsFailure({
  required final AppError error,
}) extends DetailsState with DetailsFailureMappable;
