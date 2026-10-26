sealed class AppError {
  const AppError();
}

class const ConnectionError() extends AppError;

class const ApiError(
  final String message,
) extends AppError;

class const AuthError() extends AppError;

class const ValidationError() extends AppError;

class const NotFoundError() extends AppError;

class const SyncPendingError() extends AppError;

class const InvalidBackupError() extends AppError;

class const ClockWrongError() extends AppError;

class const TextToSpeechUnavailableError() extends AppError;

class const TranslationQuotaExceededError(
  final int limit,
) extends AppError;

class const StockImageQuotaExceededError(
  final int limit,
) extends AppError;

class const ImageLabelingQuotaExceededError(
  final int limit,
) extends AppError;

class const AiUnavailableError() extends AppError;

class const CameraPermissionError() extends AppError;

class const ReportLimitError() extends AppError;

class const ReportUnavailableError() extends AppError;

class const CameraUnavailableError() extends AppError;

class const UnexpectedError([
  final String? message,
]) extends AppError;
