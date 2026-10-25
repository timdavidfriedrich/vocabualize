import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/widgets/vocabulary_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<bool> confirmsVocabularyDelete(BuildContext context, Vocabulary vocabulary) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => _DeleteVocabularyDialog(vocabulary: vocabulary),
  );
  return isConfirmed ?? false;
}

class const _DeleteVocabularyDialog({
  required final Vocabulary _vocabulary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.all(Spacing.m),
      contentPadding: const EdgeInsets.fromLTRB(Spacing.xl, Spacing.s, Spacing.xl, 0),
      title: Text(context.s.vocabularyDeleteTitle),
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: VocabularyTileLeading(vocabulary: _vocabulary),
        title: Text(_vocabulary.target, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          _vocabulary.source,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.t.bodyLarge?.copyWith(color: context.c.outline),
        ),
      ),
      actionsPadding: const EdgeInsets.all(Spacing.xl),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(Spacing.s)),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.s.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: context.c.error),
          child: Text(context.s.delete),
        ),
      ],
    );
  }
}
