import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/services/text_to_speech.dart';

class InfoDialog extends StatelessWidget {
  final Vocabulary vocabulary;

  const InfoDialog({super.key, required this.vocabulary});

  @override
  Widget build(BuildContext context) {
    TTS tts = TTS.instance;

    speak() {
      tts.stop;
      tts.speak(vocabulary);
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
      // TODO: Replace with arb
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(vocabulary.target)),
          IconButton(onPressed: () => speak(), icon: const Icon(Icons.volume_up_rounded, size: 32)),
        ],
      ),
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
        ElevatedButton(
          // TODO: Move onPressed to method
          onPressed: () => Navigator.of(context).pop(),
          // TODO: Replace with arb
          child: const Text('Close'),
        ),
      ],
    );
  }
}
