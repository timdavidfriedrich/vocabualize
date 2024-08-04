import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/widgets/start.dart';
import 'package:vocabualize/src/common/models/vocabulary.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';

class DuplicateDialog extends StatelessWidget {
  final Vocabulary vocabulary;

  const DuplicateDialog({super.key, required this.vocabulary});

  void _cancel() {
    Navigator.popUntil(Global.context, ModalRoute.withName(Start.routeName));
  }

  void _addAnyway() {
    RecordService.save(vocabulary: vocabulary);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // TODO: Replace with arb
      title: const Text('Duplicate'),
      // TODO: Replace with arb
      content: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(text: "It seems that "),
            TextSpan(text: " '${vocabulary.source}' ", style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " already exists in your collection.\n\nAdd it anyway?"),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => _cancel(),
          // TODO: Replace with arb
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _addAnyway(),
          // TODO: Replace with arb
          child: const Text('Add'),
        ),
      ],
    );
  }
}
