import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'wait_for_data_state.mapper.dart';

@MappableClass()
class const WaitForDataState({
  required final bool isBusy,
  required final AppError? error,
}) with WaitForDataStateMappable;
