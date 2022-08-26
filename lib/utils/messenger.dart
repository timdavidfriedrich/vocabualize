import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';

class Messenger {
  static void loadingAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  static void saveMessage(BuildContext context, String text) {
    Vocabulary vocabulary = Provider.of<VocProv>(context, listen: false)
        .getVocabularyList()
        .firstWhere((vocabulary) => vocabulary.getSource() == text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: RichText(
        text: TextSpan(
          style: TextStyle(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
          children: [
            TextSpan(
                text: text.substring(0, 1).toUpperCase() +
                    text.substring(1, text.length)),
            const TextSpan(text: " has been saved as "),
            TextSpan(
                text: vocabulary.getTarget(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground)),
            const TextSpan(text: "!"),
          ],
        ),
      ),
      action: SnackBarAction(
        label: "Delete",
        onPressed: () => Provider.of<VocProv>(context, listen: false)
            .removeFromVocabularyList(vocabulary),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    ));
  }
}
