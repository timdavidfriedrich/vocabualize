import 'package:core/error/app_error.dart';
import 'package:feature_report/presentation/report_bloc.dart';
import 'package:feature_report/presentation/report_event.dart';
import 'package:feature_report/presentation/report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/report_form.dart';

const _minMessageLines = 6;

class const ReportScreen({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final message = useValueListenable(controller).text.trim();
    return MultiBlocListener(
      listeners: [
        BlocListener<ReportBloc, ReportState>(
          listenWhen: (previous, current) => current is ReportSent,
          listener: (context, state) {
            context.showToast(context.s.reportFeedbackSentMessage);
            context.closeScreen();
          },
        ),
        BlocListener<ReportBloc, ReportState>(
          listenWhen: (previous, current) => switch (current) {
            ReportEditing(error: AppError()) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case ReportEditing(error: final error?)) {
              context.showToast(error.toMessage(context));
            }
          },
        ),
      ],
      child: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) => ReportForm(
          title: context.s.reportFeedbackTitle,
          header: Text(context.s.reportFeedbackMessage, style: context.t.bodyLarge),
          controller: controller,
          fieldHint: context.s.reportFeedbackFieldHint,
          minLines: _minMessageLines,
          canSend: message.isNotEmpty,
          isSending: switch (state) {
            ReportEditing(:final isSending) => isSending,
            ReportSent() => true,
          },
          onSend: () =>
              context.read<ReportBloc>().add(ReportSendRequested(message: controller.text)),
        ),
      ),
    );
  }
}
