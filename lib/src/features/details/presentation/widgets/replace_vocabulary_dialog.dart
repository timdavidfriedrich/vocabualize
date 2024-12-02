import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

class ReplaceVocabularyDialog extends StatelessWidget {
  const ReplaceVocabularyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void cancel() {
      context.pop(false);
    }

    void replace() {
      context.pop(true);
    }

    return AlertDialog.adaptive(
      // TODO: Replace with arb
      title: const Text('Replace'),
      // TODO: Replace with arb
      content: const Text("Retranslate and replace the vocabulary?"),
      actions: [
        OutlinedButton(
          onPressed: () => cancel(),
          // TODO: Replace with arb
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () => replace(),
          // TODO: Replace with arb
          child: const Text('Replace'),
        ),
      ],
    );
  }
}
