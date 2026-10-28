import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<bool> confirmsRetranslation(BuildContext context) async {
  final retranslates = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => const _ReplaceDialog(),
  );
  return retranslates ?? false;
}

class const _ReplaceDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(context.s.detailsReplaceTitle),
      content: Text(context.s.detailsReplaceMessage),
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.s.no),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.s.detailsReplaceButton),
            ),
          ],
        ),
      ],
    );
  }
}
