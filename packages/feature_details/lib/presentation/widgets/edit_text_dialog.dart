import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _maxLines = 4;

Future<String?> requestsEditedText(
  BuildContext context, {
  required String text,
  required String label,
  VoidCallback? onReportRequested,
}) {
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => _EditTextDialog(
      text: text,
      label: label,
      onReportRequested: onReportRequested,
    ),
  );
}

class const _EditTextDialog({
  required final String _text,
  required final String _label,
  required final VoidCallback? _onReportRequested,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _text);
    final hasChanged = useListenableSelector(
      controller,
      () => controller.text.trim().isNotEmpty && controller.text.trim() != _text,
    );
    return AlertDialog.adaptive(
      contentPadding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.xs, Spacing.s, Spacing.s),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: _maxLines,
                  decoration: InputDecoration(
                    hintText: _text,
                    label: Text(_label),
                  ),
                ),
              ),
              const SizedBox(width: Spacing.xs),
              IconButton(
                onPressed: () =>
                    Navigator.of(context).pop(hasChanged ? controller.text.trim() : null),
                icon: Icon(hasChanged ? Icons.save_rounded : Icons.close_rounded),
              ),
            ],
          ),
          if (_onReportRequested case final onReportRequested?) ...[
            const SizedBox(height: Spacing.xs),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onReportRequested();
              },
              child: Text(
                context.s.detailsReportTranslationButton,
                style: context.t.bodySmall?.copyWith(color: context.c.outline),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
