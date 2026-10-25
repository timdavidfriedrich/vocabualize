import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<bool> confirmsAddingDuplicate(BuildContext context, String source) async {
  final addsAnyway = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => _DuplicateDialog(source: source),
  );
  return addsAnyway ?? false;
}

class const _DuplicateDialog({
  required final String _source,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(context.s.detailsDuplicateTitle),
      insetPadding: const EdgeInsets.all(Spacing.xxl),
      contentPadding: const EdgeInsets.fromLTRB(Spacing.xl, Spacing.xl, Spacing.xl, 0),
      content: Text(context.s.detailsDuplicateMessage(_source)),
      actionsPadding: const EdgeInsets.all(Spacing.m),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(Spacing.s)),
          child: Text(context.s.detailsDuplicateAddButton),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.s.cancel),
        ),
      ],
    );
  }
}
