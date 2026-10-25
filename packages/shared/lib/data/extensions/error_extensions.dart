import 'package:core/error/app_error.dart';
import 'package:shared/data/data_sources/clock_data_source.dart';

extension ErrorExtensions on Object {
  AppError toAppError() => switch (this) {
    ClockWrongException() => const ClockWrongError(),
    _ => UnexpectedError(toString()),
  };
}
