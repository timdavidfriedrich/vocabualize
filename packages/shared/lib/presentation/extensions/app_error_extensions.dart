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
    UnexpectedError() => context.s.errorUnexpected,
  };
}
