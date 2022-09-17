import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/widgets/save_message_route.dart';

class Messenger {
  static void loadingAnimation() {
    showDialog(
      context: Keys.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(backgroundColor: Colors.transparent, elevation: 0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  static void showSaveMessage(Vocabulary vocabulary) async {
    Navigator.push(Keys.context, SaveMessageRoute(vocabulary: vocabulary));
  }

  static void editDialog(Vocabulary vocabulary) {
    vocabulary = Provider.of<VocabularyProvider>(Keys.context, listen: false).vocabularyList.firstWhere((voc) => voc == vocabulary);
    bool popped = false;
    showGeneralDialog(
      context: Keys.context,
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = const ElasticOutCurve(0.9).transform(animation1.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0, curvedValue * 200, 0),
          child: AlertDialog(
            title: const Text("Edit"),
            // TODO: add TextFields (source, target) and the tags as Chips
            content: Text(vocabulary.target),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (!popped) {
                    Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary);
                    Navigator.pop(context);
                    popped = true;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  foregroundColor: Theme.of(context).colorScheme.primary,
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
}
