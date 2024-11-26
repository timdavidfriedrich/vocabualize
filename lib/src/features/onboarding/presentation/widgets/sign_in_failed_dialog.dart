import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

// TODO: Remove Firebase from SignInFailedDialog
class SignInFailedDialog extends StatelessWidget {
  final FirebaseAuthException error;

  const SignInFailedDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    void okay() {
      context.pop();
    }

    String errorMessage() {
      // TODO: Replace with arb
      switch (error.code) {
        case "invalid-email":
        case "user-not-found":
        case "wrong-password":
          return "The email or password is incorrect. Try again.";
        case "user-disabled":
          return "This account has been disabled.";
        default:
          return "An error occured.";
      }
    }

    return AlertDialog(
      // TODO: Replace with arb
      title: const Text("Sign in failed"),
      content: Text(errorMessage()),
      actions: [
        ElevatedButton(
          onPressed: () => okay(),
          // TODO: Replace with arb
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
