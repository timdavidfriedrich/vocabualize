import 'package:core/error/app_error.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _translationKind = "translation";

extension ErrorExtensions on Object {
  AppError toAppError() => switch (this) {
    ClockWrongException() => const ClockWrongError(),
    AiQuotaExceededException(kind: _translationKind, :final limit) => TranslationQuotaExceededError(
      limit,
    ),
    AiQuotaExceededException(:final limit) => StockImageQuotaExceededError(limit),
    AiUnavailableException() => const AiUnavailableError(),
    _ => UnexpectedError(toString()),
  };

  AppError toAiError() => switch (toAppError()) {
    UnexpectedError() => const AiUnavailableError(),
    final error => error,
  };
}
