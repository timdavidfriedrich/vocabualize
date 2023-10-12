import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class InfoSnackBarContent extends StatelessWidget {
  final Vocabulary vocabulary;

  const InfoSnackBarContent({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context) {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              children: [
                // TODO: Replace with arb
                const TextSpan(text: "Created: ", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: DateFormat("dd.MM.yyyy").format(vocabulary.creationDate)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              children: [
                // TODO: Replace with arb
                const TextSpan(text: "Reappears: ", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: reappearsIn()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
