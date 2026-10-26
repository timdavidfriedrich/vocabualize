import 'package:core/error/app_error.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _translationKind = "translation";
const _stockSearchKind = "stockSearch";
const _imageLabelingKind = "imageLabeling";

extension ErrorExtensions on Object {
  AppError toAppError() => switch (this) {
    ClockWrongException() => const ClockWrongError(),
    AiQuotaExceededException(kind: _translationKind, :final limit) => TranslationQuotaExceededError(
      limit,
    ),
    AiQuotaExceededException(kind: _stockSearchKind, :final limit) => StockImageQuotaExceededError(
      limit,
    ),
    AiQuotaExceededException(kind: _imageLabelingKind, :final limit) =>
      ImageLabelingQuotaExceededError(limit),
    AiQuotaExceededException() || AiUnavailableException() => const AiUnavailableError(),
    ServerpodClientNetworkException() => const ConnectionError(),
    _ => UnexpectedError(toString()),
  };

  AppError toAiError() => switch (toAppError()) {
    UnexpectedError() => const AiUnavailableError(),
    final error => error,
  };
}
