import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_report/presentation/feedback_bloc.dart';
import 'package:feature_report/presentation/feedback_event.dart';
import 'package:feature_report/presentation/feedback_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';

const _maxMessageLength = 2000;
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
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.reportFeedbackTitle)),
        body: ListView(
          padding: const EdgeInsets.all(Spacing.m),
          children: [
            Text(context.s.reportFeedbackMessage, style: context.t.bodyLarge),
            const SizedBox(height: Spacing.m),
            TextField(
              controller: controller,
              minLines: _minMessageLines,
              maxLines: null,
              maxLength: _maxMessageLength,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: context.s.reportFeedbackFieldHint),
            ),
            Text(
              context.s.reportFeedbackContextHint,
              style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant),
            ),
            const SizedBox(height: Spacing.m),
            ConnectionRequiredNotice(message: context.s.reportOfflineMessage),
            BlocBuilder<ConnectivityCubit, bool>(
              builder: (context, isConnected) => BlocBuilder<FeedbackBloc, FeedbackState>(
                builder: (context, state) {
                  final isSending = switch (state) {
                    FeedbackEditing(:final isSending) => isSending,
                    FeedbackSent() => true,
                  };
                  return ElevatedButton(
                    onPressed: isSending || !isConnected || message.isEmpty
                        ? null
                        : () => context.read<FeedbackBloc>().add(
                            FeedbackSendRequested(message: controller.text),
                          ),
                    child: isSending
                        ? const SizedBox.square(
                            dimension: Spacing.iconS,
                            child: CircularProgressIndicator(
                              strokeWidth: Spacing.borderWidthMedium,
                            ),
                          )
                        : Text(context.s.reportSendButton),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
