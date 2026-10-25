import 'package:flutter/material.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/sign_in_result.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<bool> confirmsAccountSwitch(BuildContext context, AccountConflict conflict) async {
  final switchesAccount = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => _AccountConflictDialog(conflict: conflict),
  );
  return switchesAccount ?? false;
}

class const _AccountConflictDialog({
  required final AccountConflict _conflict,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final previous = _conflict.previous;
    final next = _conflict.next;
    return AlertDialog(
      title: Text(context.s.accountConflictTitle),
      content: Text(
        context.s.accountConflictMessage(_fullLabel(context, previous), _fullLabel(context, next)),
      ),
      actionsOverflowDirection: VerticalDirection.down,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            context.s.accountConflictKeepButton(_emailLabel(context, previous)),
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: context.c.error),
          child: Text(
            context.s.accountConflictSwitchButton(
              _emailLabel(context, previous),
              _emailLabel(context, next),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  String _fullLabel(BuildContext context, GoogleAccount account) =>
      switch ((account.name, account.email)) {
        (final name?, final email?) => "$name ($email)",
        (null, final email?) => email,
        (final name?, null) => name,
        (null, null) => context.s.accountConflictUnknownAccount,
      };

  String _emailLabel(BuildContext context, GoogleAccount account) =>
      account.email ?? _fullLabel(context, account);
}
