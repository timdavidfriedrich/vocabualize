import 'package:core/error/app_result.dart';
import 'package:feature_report/presentation/report_event.dart';
import 'package:feature_report/presentation/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/report_repository.dart';

@injectable
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc(this._reportRepository) : super(const ReportEditing(isSending: false, error: null)) {
    on<ReportSendRequested>(_onSendRequested);
  }

  final ReportRepository _reportRepository;

  Future<void> _onSendRequested(ReportSendRequested event, Emitter<ReportState> emit) async {
    final message = event.message.trim();
    if (message.isEmpty) return;
    if (state case ReportEditing(isSending: false)) {
      emit(const ReportEditing(isSending: true, error: null));
      emit(switch (await _reportRepository.sendFeedback(message)) {
        Success() => const ReportSent(),
        Failure(:final error) => ReportEditing(isSending: false, error: error),
      });
    }
  }
}
