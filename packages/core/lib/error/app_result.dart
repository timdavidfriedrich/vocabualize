import 'package:core/error/app_error.dart';

sealed class AppResult<T> {
  const AppResult();
}

class const Success<T>(
  final T data,
) extends AppResult<T>;

class const Failure<T>(
  final AppError error,
) extends AppResult<T>;
