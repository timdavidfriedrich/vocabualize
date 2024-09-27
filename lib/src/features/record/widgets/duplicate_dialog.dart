import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/presentation/widgets/start.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';

class DuplicateDialog extends ConsumerWidget {
  final Vocabulary vocabulary;

  const DuplicateDialog({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void cancel() {
      Navigator.popUntil(Global.context, ModalRoute.withName(Start.routeName));
    }

    void addAnyway() {
      RecordService().save(unwantedRef: ref, vocabulary: vocabulary,);
    }

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
          onPressed: () => cancel(),
          // TODO: Replace with arb
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => addAnyway(),
          // TODO: Replace with arb
          child: const Text('Add'),
        ),
      ],
    );
  }
}
