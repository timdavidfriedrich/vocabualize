import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const SignOutBlockedDialog({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.s.settingsSignOutBlockedTitle),
      content: Text(context.s.settingsSignOutBlockedMessage),
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.s.settingsSignOutAnywayButton),
            ),
          ],
        ),
      ],
    );
  }
}
