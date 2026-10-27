import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/report_form.dart';

const _minNoteLines = 3;

Future<String?> requestsTranslationReportNote(
  BuildContext context, {
  required String source,
  required String target,
}) {
  return showDialog<String>(
    context: context,
    useSafeArea: false,
    builder: (dialogContext) => _ReportTranslationDialog(source: source, target: target),
  );
}

class const _ReportTranslationDialog({
  required final String _source,
  required final String _target,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Dialog.fullscreen(
      child: ReportForm(
        title: context.s.reportTranslationTitle,
        header: _WordPair(source: _source, target: _target),
        controller: controller,
        fieldHint: context.s.reportTranslationNoteHint,
        minLines: _minNoteLines,
        canSend: true,
        isSending: false,
        onSend: () => Navigator.of(context).pop(controller.text.trim()),
      ),
    );
  }
}

class const _WordPair({
  required final String _source,
  required final String _target,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Text(_source, style: context.t.bodyLarge)),
        const SizedBox(width: Spacing.xs),
        const Icon(Icons.arrow_forward_rounded),
        const SizedBox(width: Spacing.xs),
        Flexible(
          child: Text(_target, style: context.t.bodyLarge?.copyWith(color: context.c.error)),
        ),
      ],
    );
  }
}
