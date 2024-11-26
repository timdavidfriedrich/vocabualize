import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

class DisconnectedDialog extends StatelessWidget {
  const DisconnectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.all(32),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      actionsAlignment: MainAxisAlignment.end,
      title: Text(AppLocalizations.of(context)?.core_disconnected ?? ""),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(AppLocalizations.of(context)?.core_disconnected_description ?? ""),
      ),
      actions: [
        ElevatedButton(
          // TODO: move onPressed to method
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)?.core_disconnected_okayButton ?? ""),
        ),
      ],
    );
  }
}
