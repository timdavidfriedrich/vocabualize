import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/messenger.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';

class VocListTile extends StatelessWidget {
  final Vocabulary vocabulary;
  const VocListTile({required this.vocabulary, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: Key(vocabulary.toString()),
        onDismissed: (direction) async => await Provider.of<VocProv>(context, listen: false).removeFromVocabularyList(vocabulary),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            Messenger.editDialog(vocabulary);
            return false;
          } else {
            return true;
          }
        },
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.error),
          child: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.onError),
        ),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: Icon(Icons.edit_rounded, color: Theme.of(context).colorScheme.onPrimary),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          // ?: onTap oder longPress?
          onTap: () => Messenger.editDialog(vocabulary),
          // leading: Icon(
          //   Icons.crop_square_rounded,
          //   size: 48,
          //   color: Theme.of(context).colorScheme.onSecondary,
          // ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vocabulary.target),
              Text(vocabulary.source, style: TextStyle(color: Theme.of(context).hintColor)),
            ],
          ),
          trailing: Icon(
            Icons.circle,
            size: 16,
            color: vocabulary.levelColor,
          ),
        ),
      ),
    );
  }
}
