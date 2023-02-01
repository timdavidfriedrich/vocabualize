import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class ReplaceVocabularyDialog extends StatelessWidget {
  const ReplaceVocabularyDialog({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

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
