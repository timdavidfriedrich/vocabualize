import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class VocabularyListTile extends StatelessWidget {
  final Vocabulary vocabulary;
  const VocabularyListTile({required this.vocabulary, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: Key(vocabulary.toString()),
        onDismissed: (direction) async => await Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary),
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
          contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          // ?: onTap oder longPress?
          onTap: () => Messenger.editDialog(vocabulary),
          leading: SizedBox(
            width: 48,
            height: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(color: Theme.of(context).colorScheme.surface),
            ),
          ),
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
