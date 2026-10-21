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

class const UnexpectedError([
  final String? message,
]) extends AppError;
