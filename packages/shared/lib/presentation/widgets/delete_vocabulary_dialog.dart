import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_tile_leading.dart';

Future<bool> confirmsVocabularyDelete(
  BuildContext context, {
  required Vocabulary vocabulary,
  required Language language,
  required Language mainLanguage,
}) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => _DeleteVocabularyDialog(
      vocabulary: vocabulary,
      language: language,
      mainLanguage: mainLanguage,
    ),
  );
  return isConfirmed ?? false;
}

class const _DeleteVocabularyDialog({
  required final Vocabulary _vocabulary,
  required final Language _language,
  required final Language _mainLanguage,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      contentPadding: const EdgeInsets.fromLTRB(Spacing.xl, Spacing.s, Spacing.xl, 0),
      title: Text(context.s.vocabularyDeleteTitle),
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: VocabularyTileLeading(vocabulary: _vocabulary, language: _language),
        title: Text(
          _vocabulary.titleIn(context, _language),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          _vocabulary.promptIn(_mainLanguage),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.t.bodyLarge?.copyWith(color: context.c.outline),
        ),
      ),
      actionsPadding: const EdgeInsets.all(Spacing.xl),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
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
        ),
      ],
    );
  }
}
