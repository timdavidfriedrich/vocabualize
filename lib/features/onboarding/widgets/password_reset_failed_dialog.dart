import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocabualize/constants/common_imports.dart';

class PasswordResetFailedDialog extends StatelessWidget {
  final FirebaseAuthException error;

  const PasswordResetFailedDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    void okay() {
      Navigator.pop(context);
    }

    String errorMessage() {
      // TODO: Replace with arb
      switch (error.code) {
        case "auth/invalid-email":
        case "auth/user-not-found":
          return "There is no user corresponding to this email address. Try again.";
        case "auth/missing-android-pkg-name":
        case "auth/missing-continue-uri":
        case "auth/missing-ios-bundle-id":
        case "auth/invalid-continue-uri":
        case "auth/unauthorized-continue-uri":
        default:
          return "An error occured.";
      }
    }

    return AlertDialog(
      // TODO: Replace with arb
      title: const Text('Password reset failed'),
      // TODO: Replace with arb
      content: Text(errorMessage()),
      actions: [
        ElevatedButton(
          onPressed: () => okay(),
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
