import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/sign_in_result.dart';

part 'wait_for_data_state.mapper.dart';

@MappableClass()
sealed class WaitForDataState with WaitForDataStateMappable {
  const WaitForDataState();
}

@MappableClass()
class const WaitForDataIdle({
  required final AccountConflict? accountConflict,
  required final AppError? error,
}) extends WaitForDataState with WaitForDataIdleMappable;

@MappableClass()
class const WaitForDataBusy() extends WaitForDataState with WaitForDataBusyMappable;
