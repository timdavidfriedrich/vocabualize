import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class InfoDialog extends StatelessWidget {
  final Vocabulary vocabulary;

  const InfoDialog({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context) {
    void delete() {
      Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary);
      Navigator.pop(context);
    }

    void close() {
      Navigator.of(context).pop();
    }

    String reappearsIn() {
      DateTime now = DateTime.now();
      Duration difference = vocabulary.nextDate.difference(now);
      // TODO: Replace with arb
      if (difference.isNegative) return "Now";
      if (difference.inMinutes < 1) return "In less than a minutes";
      if (difference.inHours < 1) return "In ${difference.inMinutes} minutes";
      if (difference.inDays < 1) return "In ${difference.inHours} hours";
      if (difference.inDays <= 7) return "In ${difference.inDays} days";
      return DateFormat("dd.MM.yyyy - HH:mm").format(vocabulary.nextDate);
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
                  TextSpan(text: DateFormat("dd.MM.yyyy").format(vocabulary.creationDate)),
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
                  TextSpan(text: reappearsIn()),
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
