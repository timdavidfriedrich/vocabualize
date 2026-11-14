import 'package:core/error/app_error.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'report_state.mapper.dart';

@MappableClass()
sealed class ReportState with ReportStateMappable {
  const ReportState();
}

@MappableClass()
class const ReportEditing({
  required final bool isSending,
  required final AppError? error,
}) extends ReportState with ReportEditingMappable;

@MappableClass()
class const ReportSent() extends ReportState with ReportSentMappable;
