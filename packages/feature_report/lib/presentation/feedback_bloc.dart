import 'package:core/error/app_result.dart';
import 'package:feature_report/presentation/feedback_event.dart';
import 'package:feature_report/presentation/feedback_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/report_repository.dart';

@injectable
class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc(this._reportRepository)
    : super(const FeedbackEditing(isSending: false, error: null)) {
    on<FeedbackSendRequested>(_onSendRequested);
  }

  final ReportRepository _reportRepository;

  Future<void> _onSendRequested(FeedbackSendRequested event, Emitter<FeedbackState> emit) async {
    final message = event.message.trim();
    if (message.isEmpty) return;
    if (state case FeedbackEditing(isSending: false)) {
      emit(const FeedbackEditing(isSending: true, error: null));
      emit(switch (await _reportRepository.sendFeedback(message)) {
        Success() => const FeedbackSent(),
        Failure(:final error) => FeedbackEditing(isSending: false, error: error),
      });
    }
  }
}
