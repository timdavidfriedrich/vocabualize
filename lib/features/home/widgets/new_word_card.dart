import 'package:flutter/material.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class NewWordCard extends StatelessWidget {
  final Vocabulary vocabulary;
  const NewWordCard({required this.vocabulary, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: () => Messenger.editDialog(vocabulary),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 128,
              height: 128,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(color: Theme.of(context).colorScheme.surface),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 128,
              child: Text(vocabulary.target, style: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(
              width: 128,
              child: Text(vocabulary.source, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor)),
            ),
          ],
        ),
      ),
    );
  }
}
