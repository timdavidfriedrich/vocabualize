import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/features/home/domain/extensions/vocabulary_extensions.dart';

class InfoDialog extends ConsumerWidget {
  final Vocabulary vocabulary;

  const InfoDialog({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void delete() {
      ref.read(deleteVocabularyUseCaseProvider(vocabulary));
      Navigator.pop(context);
    }

    void close() {
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text(vocabulary.target),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                children: [
                  // TODO: Replace with arb
                  const TextSpan(text: "Created:\n", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: DateFormat("dd.MM.yyyy").format(vocabulary.created)),
                ],
              ),
            ),
          ),
          Flexible(
            child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                children: [
                  // TODO: Replace with arb
                  const TextSpan(text: "Reappears:\n", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: vocabulary.reappearsIn()),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => delete(),
              child: const Icon(Icons.delete_rounded),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => close(),
                // TODO: Replace with arb
                child: const Text('Close'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
