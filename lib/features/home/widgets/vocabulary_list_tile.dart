import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class VocabularyListTile extends StatelessWidget {
  const VocabularyListTile({super.key, required this.vocabulary});

  final Vocabulary vocabulary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: Key(vocabulary.toString()),
        onDismissed: (direction) async => await Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            Messenger.showInfoDialog(vocabulary);
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
          contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: () => Messenger.showInfoDialog(vocabulary),

          /// TODO: add image
          leading: Provider.of<SettingsProvider>(context).areImagesDisabled
              ? null
              : SizedBox(
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
          title: Text(vocabulary.target),
          subtitle: Text(vocabulary.source, style: TextStyle(color: Theme.of(context).hintColor)),
          trailing: Icon(
            Icons.circle,
            size: 16,
            color: vocabulary.level.color,
          ),
        ),
      ),
    );
  }
}
