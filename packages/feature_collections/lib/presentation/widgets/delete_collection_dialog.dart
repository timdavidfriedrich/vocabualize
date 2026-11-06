import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

Future<bool> confirmsCollectionDelete(BuildContext context) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => const _DeleteCollectionDialog(),
  );
  return isConfirmed ?? false;
}

class const _DeleteCollectionDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(context.s.collectionsDeleteTitle),
      content: Text(context.s.collectionsDeleteMessage),
      actionsPadding: const EdgeInsets.all(Spacing.xl),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            TonalButton(
              isCompact: true,
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
