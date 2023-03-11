import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/firebase/firebase_service.dart';
import 'package:vocabualize/features/onboarding/screens/select_language_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  Timer? reloadTimer;

  void _reload() async {
    await FirebaseService.reloadUser().whenComplete(() {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        reloadTimer?.cancel();
        Navigator.pushNamed(context, SelectLanguageScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    reloadTimer = Timer.periodic(const Duration(seconds: 3), (_) => _reload());
  }

  @override
  void dispose() {
    reloadTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TODO: Replace with arb
                  Text("Verify your email", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  // TODO: Replace with arb
                  const Text("We sent you an email with a link. Please, click on it to verify your email address."),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => FirebaseService.sendVerificationEmail(),
                    // TODO: Replace with arb
                    child: const Text("Resend verification email"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
