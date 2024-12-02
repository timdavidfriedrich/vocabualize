import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

class DisconnectedDialog extends StatelessWidget {
  const DisconnectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void okay() {
      context.pop();
    }

    final strings = AppLocalizations.of(context);
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.all(Dimensions.dialogInsetSpacing),
      contentPadding: const EdgeInsets.only(
        left: Dimensions.semiLargeSpacing,
        right: Dimensions.semiLargeSpacing,
        top: Dimensions.semiLargeSpacing,
        bottom: 0,
      ),
      actionsPadding: const EdgeInsets.all(Dimensions.semiLargeSpacing),
      actionsAlignment: MainAxisAlignment.end,
      title: Text(strings?.core_disconnected ?? ""),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(strings?.core_disconnected_description ?? ""),
      ),
      actions: [
        ElevatedButton(
          onPressed: okay,
          child: Text(strings?.core_disconnected_okayButton ?? ""),
        ),
      ],
    );
  }
}
