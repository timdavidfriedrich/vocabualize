import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/processed_image.dart';

part 'scan_state.mapper.dart';

@MappableClass()
sealed class ScanState with ScanStateMappable {
  const ScanState();
}

@MappableClass()
class const ScanCapturing({
  required final bool isProcessing,
  required final AppError? error,
}) extends ScanState with ScanCapturingMappable;

@MappableClass()
class const ScanReviewing({
  required final ProcessedImage photo,
  required final ScanSuggestions suggestions,
}) extends ScanState with ScanReviewingMappable;

@MappableClass()
sealed class ScanSuggestions with ScanSuggestionsMappable {
  const ScanSuggestions();
}

@MappableClass()
class const ScanSuggestionsLoading() extends ScanSuggestions with ScanSuggestionsLoadingMappable;

@MappableClass()
class const ScanSuggestionsLoaded({
  required final List<String> labels,
}) extends ScanSuggestions with ScanSuggestionsLoadedMappable;

@MappableClass()
class const ScanSuggestionsSignInRequired()
    extends ScanSuggestions
    with ScanSuggestionsSignInRequiredMappable;

@MappableClass()
class const ScanSuggestionsOffline() extends ScanSuggestions with ScanSuggestionsOfflineMappable;

@MappableClass()
class const ScanSuggestionsFailed({
  required final AppError error,
}) extends ScanSuggestions with ScanSuggestionsFailedMappable;
