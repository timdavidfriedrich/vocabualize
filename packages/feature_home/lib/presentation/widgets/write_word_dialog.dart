import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _maxLines = 2;

Future<String?> requestsWrittenWord(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => const _WriteWordDialog(),
  );
}

class const _WriteWordDialog() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final hasText = useListenableSelector(controller, () => controller.text.trim().isNotEmpty);
    void submit() => Navigator.of(context).pop(hasText ? controller.text.trim() : null);
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
      contentPadding: const EdgeInsets.all(Spacing.s),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => submit(),
                minLines: 1,
                maxLines: _maxLines,
                decoration: InputDecoration(hintText: context.s.homeWriteHint),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            IconButton(
              onPressed: submit,
              icon: Icon(hasText ? Icons.arrow_forward_rounded : Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
