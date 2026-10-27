import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<String?> requestsTagName(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => const _AddTagDialog(),
  );
}

class const _AddTagDialog() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final hasText = useListenableSelector(controller, () => controller.text.trim().isNotEmpty);
    void submit() => Navigator.of(context).pop(hasText ? controller.text.trim() : null);
    return AlertDialog.adaptive(
      contentPadding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.s, Spacing.xs, Spacing.s),
      content: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submit(),
              decoration: InputDecoration(
                hintText: context.s.detailsCollectionNameHint,
                label: Text(context.s.detailsCollectionNameLabel),
              ),
            ),
          ),
          const SizedBox(width: Spacing.xs),
          IconButton(
            onPressed: submit,
            icon: Icon(hasText ? Icons.save_rounded : Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}
