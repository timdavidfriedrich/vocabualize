import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

class PasswordsDontMatchDialog extends StatelessWidget {
  const PasswordsDontMatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      // TODO: Replace with arb
      title: const Text("Sign up failed"),
      // TODO: Replace with arb
      content: const Text("The passwords don't match. Please try again."),
      actions: [
        ElevatedButton(
          onPressed: () => context.pop(),
          // TODO: Replace with arb
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
