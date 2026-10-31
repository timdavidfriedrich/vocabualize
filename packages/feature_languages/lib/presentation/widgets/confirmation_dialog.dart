import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<bool> confirms(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool isDestructive = false,
}) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog.adaptive(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.all(Spacing.xl),
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.s.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: isDestructive
                  ? ElevatedButton.styleFrom(backgroundColor: context.c.error)
                  : null,
              child: Text(confirmLabel),
            ),
          ],
        ),
      ],
    ),
  );
  return isConfirmed ?? false;
}
