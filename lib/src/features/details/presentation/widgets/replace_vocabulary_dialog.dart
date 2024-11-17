import 'package:flutter/material.dart';

class ReplaceVocabularyDialog extends StatelessWidget {
  const ReplaceVocabularyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void cancel() {
      Navigator.pop(context, false);
    }

    void replace() {
      Navigator.pop(context, true);
    }

    return AlertDialog(
      // TODO: Replace with arb
      title: const Text('Replace'),
      // TODO: Replace with arb
      content: const Text("Retranslate and replace the vocabulary?"),
      actions: [
        OutlinedButton(
          onPressed: () => cancel(),
          // TODO: Replace with arb
          child: const Text('Cancel'),
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
