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
    TranslationQuotaExceededError(:final limit) => context.s.errorTranslationQuotaExceeded(limit),
    StockImageQuotaExceededError(:final limit) => context.s.errorStockImageQuotaExceeded(limit),
    ImageLabelingQuotaExceededError(:final limit) => context.s.errorImageLabelingQuotaExceeded(
      limit,
    ),
    AiUnavailableError() => context.s.errorAiUnavailable,
    CameraPermissionError() => context.s.errorCameraPermission,
    ReportLimitError() => context.s.errorReportLimit,
    ReportUnavailableError() => context.s.errorReportUnavailable,
    CameraUnavailableError() => context.s.errorCameraUnavailable,
    UnexpectedError() => context.s.errorUnexpected,
  };
}
