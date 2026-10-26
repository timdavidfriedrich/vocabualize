import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/connection_required_notice.dart';

const _maxNoteLength = 2000;
const _minNoteLines = 3;

Future<String?> requestsTranslationReportNote(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => const _ReportTranslationDialog(),
  );
}

class const _ReportTranslationDialog() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return AlertDialog(
      title: Text(context.s.reportTranslationTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            minLines: _minNoteLines,
            maxLines: null,
            maxLength: _maxNoteLength,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: context.s.reportTranslationNoteHint),
          ),
          Text(
            context.s.reportFeedbackContextHint,
            style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(height: Spacing.s),
          ConnectionRequiredNotice(message: context.s.reportOfflineMessage),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.s.cancel),
        ),
        BlocBuilder<ConnectivityCubit, bool>(
          builder: (context, isConnected) => FilledButton(
            onPressed: isConnected ? () => Navigator.of(context).pop(controller.text.trim()) : null,
            child: Text(context.s.reportSendButton),
          ),
        ),
      ],
    );
  }
}
