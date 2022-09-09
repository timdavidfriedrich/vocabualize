import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';

class Messenger {
  static void loadingAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(backgroundColor: Colors.transparent, elevation: 0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  static void editDialog(BuildContext context, Vocabulary vocabulary) {
    vocabulary = Provider.of<VocProv>(context, listen: false).getVocabularyList().firstWhere((voc) => voc == vocabulary);
    bool popped = false;
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionDuration: const Duration(milliseconds: 1000),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = Curves.elasticOut.transform(animation1.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0, curvedValue * 200, 0),
          child: AlertDialog(
            title: const Text("Edit"),
            // TODO: add TextFields (source, target) and the tags as Chips
            content: Text(vocabulary.getTarget()),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (!popped) {
                    Provider.of<VocProv>(context, listen: false).removeFromVocabularyList(vocabulary);
                    Navigator.pop(context);
                    popped = true;
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.surface,
                  onPrimary: Theme.of(context).colorScheme.primary,
                ),
                child: const Text("Delete"),
              ),
              // TODO: Save TextField and Chip data on clicked, pop()
              ElevatedButton(
                onPressed: () {
                  if (!popped) {
                    Navigator.pop(context);
                    popped = true;
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  static void saveMessage(BuildContext context, String text) {
    Vocabulary vocabulary = Provider.of<VocProv>(context, listen: false).getVocabularyList().where((vocabulary) => vocabulary.getSource() == text).last;
    Flushbar(
      margin: const EdgeInsets.all(32),
      borderRadius: BorderRadius.circular(16),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 5),
      boxShadows: [BoxShadow(offset: const Offset(0, 4), blurRadius: 8, color: Colors.black.withOpacity(0.42))],
      messageText: RichText(
        text: TextSpan(
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6)),
          children: [
            TextSpan(text: text.substring(0, 1).toUpperCase() + text.substring(1, text.length)),
            const TextSpan(text: " has been saved as "),
            TextSpan(text: vocabulary.getTarget(), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary)),
            const TextSpan(text: "!"),
          ],
        ),
      ),
      mainButton: TextButton(
        onPressed: () => Provider.of<VocProv>(context, listen: false).removeFromVocabularyList(vocabulary),
        child: Text("Delete", style: Theme.of(context).textTheme.labelMedium),
      ),
    ).show(context);
  }
}
