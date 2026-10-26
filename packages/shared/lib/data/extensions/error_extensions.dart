import 'package:core/error/app_error.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _translationKind = "translation";
const _stockImageSearchKind = "stockImageSearch";
const _imageLabelingKind = "imageLabeling";
const _monthPeriod = "month";
const _freeTier = "free";
const _reportLimited = "limited";

extension ErrorExtensions on Object {
  AppError toAppError() => switch (this) {
    ClockWrongException() => const ClockWrongError(),
    QuotaExceededException(kind: _translationKind, :final limit, :final upgradeTier) =>
      TranslationQuotaExceededError(limit: limit, canSignInForMore: upgradeTier == _freeTier),
    QuotaExceededException(kind: _stockImageSearchKind, :final limit, :final upgradeTier) =>
      StockImageQuotaExceededError(limit: limit, canSignInForMore: upgradeTier == _freeTier),
    QuotaExceededException(
      kind: _imageLabelingKind,
      :final limit,
      :final period,
      :final upgradeTier,
    ) =>
      ImageLabelingQuotaExceededError(
        limit: limit,
        isMonthly: period == _monthPeriod,
        canSignInForMore: upgradeTier == _freeTier,
      ),
    QuotaExceededException() ||
    ServiceUnavailableException() ||
    InstallRejectedException() => const ServiceUnavailableError(),
    ServerpodClientNetworkException() => const ConnectionError(),
    ReportRejectedException(reason: _reportLimited) => const ReportLimitError(),
    ReportRejectedException() => const ReportUnavailableError(),
    _ => UnexpectedError(toString()),
  };

  AppError toServiceError() => switch (toAppError()) {
    UnexpectedError() => const ServiceUnavailableError(),
    final error => error,
  };
}
