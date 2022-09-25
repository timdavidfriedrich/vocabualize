import 'package:flutter/material.dart';

class DisconnectedDialog extends StatelessWidget {
  const DisconnectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(32),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      actionsAlignment: MainAxisAlignment.end,
      title: const Text("You're offline"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Text("You must be online, in order to add vocabularies. Please check your internet connection. "),
      ),
      actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Okay"))],
    );
  }
}
