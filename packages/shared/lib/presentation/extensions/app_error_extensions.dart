import 'package:core/error/app_error.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension AppErrorExtensions on AppError {
  String toMessage(BuildContext context) => switch (this) {
    ConnectionError() => context.s.errorConnection,
    ApiError(:final message) => context.s.errorApi(message),
    AuthError() => context.s.errorAuth,
    ValidationError() => context.s.errorValidation,
    NotFoundError() => context.s.errorNotFound,
    SyncPendingError() => context.s.errorSyncPending,
    InvalidBackupError() => context.s.errorInvalidBackup,
    ClockWrongError() => context.s.errorClockWrong,
    TextToSpeechUnavailableError() => context.s.errorTextToSpeechUnavailable,
    TranslationQuotaExceededError(:final limit, :final canSignInForMore) => _quotaMessage(
      context,
      context.s.errorTranslationQuotaExceeded(limit),
      canSignInForMore: canSignInForMore,
    ),
    StockImageQuotaExceededError(:final limit, :final canSignInForMore) => _quotaMessage(
      context,
      context.s.errorStockImageQuotaExceeded(limit),
      canSignInForMore: canSignInForMore,
    ),
    ImageLabelingQuotaExceededError(:final limit, isMonthly: true, :final canSignInForMore) =>
      _quotaMessage(
        context,
        context.s.errorImageLabelingMonthlyQuotaExceeded(limit),
        canSignInForMore: canSignInForMore,
      ),
    ImageLabelingQuotaExceededError(:final limit, :final canSignInForMore) => _quotaMessage(
      context,
      context.s.errorImageLabelingQuotaExceeded(limit),
      canSignInForMore: canSignInForMore,
    ),
    ServiceUnavailableError() => context.s.errorServiceUnavailable,
    CameraPermissionError() => context.s.errorCameraPermission,
    ReportLimitError() => context.s.errorReportLimit,
    ReportUnavailableError() => context.s.errorReportUnavailable,
    CameraUnavailableError() => context.s.errorCameraUnavailable,
    UnexpectedError() => context.s.errorUnexpected,
  };
}

String _quotaMessage(BuildContext context, String message, {required bool canSignInForMore}) =>
    canSignInForMore ? context.s.errorQuotaSignInForMore(message) : message;
