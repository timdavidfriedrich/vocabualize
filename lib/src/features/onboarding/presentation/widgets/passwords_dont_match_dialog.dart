import 'package:flutter/material.dart';

class PasswordsDontMatchDialog extends StatelessWidget {
  const PasswordsDontMatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // TODO: Replace with arb
      title: const Text("Sign up failed"),
      // TODO: Replace with arb
      content: const Text("The passwords don't match. Please try again."),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          // TODO: Replace with arb
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
