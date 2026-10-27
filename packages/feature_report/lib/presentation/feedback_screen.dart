import 'package:core/error/app_error.dart';
import 'package:feature_report/presentation/feedback_bloc.dart';
import 'package:feature_report/presentation/feedback_event.dart';
import 'package:feature_report/presentation/feedback_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/report_form.dart';

const _minMessageLines = 6;

class const FeedbackScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final message = useValueListenable(controller).text.trim();
    return MultiBlocListener(
      listeners: [
        BlocListener<FeedbackBloc, FeedbackState>(
          listenWhen: (previous, current) => current is FeedbackSent,
          listener: (context, state) {
            context.showToast(context.s.reportFeedbackSentMessage);
            context.closeScreen();
          },
        ),
        BlocListener<FeedbackBloc, FeedbackState>(
          listenWhen: (previous, current) => switch (current) {
            FeedbackEditing(error: AppError()) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case FeedbackEditing(error: final error?)) {
              context.showToast(error.toMessage(context));
            }
          },
        ),
      ],
      child: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: (context, state) => ReportForm(
          title: context.s.reportFeedbackTitle,
          header: Text(context.s.reportFeedbackMessage, style: context.t.bodyLarge),
          controller: controller,
          fieldHint: context.s.reportFeedbackFieldHint,
          minLines: _minMessageLines,
          canSend: message.isNotEmpty,
          isSending: switch (state) {
            FeedbackEditing(:final isSending) => isSending,
            FeedbackSent() => true,
          },
          onSend: () =>
              context.read<FeedbackBloc>().add(FeedbackSendRequested(message: controller.text)),
        ),
      ),
    );
  }
}
