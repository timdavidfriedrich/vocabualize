import 'dart:async';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/auth_service.dart';
import 'package:vocabualize/features/onboarding/screens/sign_screen.dart';
import 'package:vocabualize/features/onboarding/screens/welcome_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "${WelcomeScreen.routeName}/${SignScreen.routeName}/ForgotPassword";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _sendButtonBlocked = false;
  Timer? _resetBlockTimer;
  final int _seconds = 60;
  late int _secondsLeft;

  Future<void> _sendPasswordResetEmail(String email) async {
    AuthService.sendPasswordResetEmail(email);
    setState(() => _sendButtonBlocked = true);
    _resetBlockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _secondsLeft -= 1);
      if (_secondsLeft == 0) {
        setState(() => _sendButtonBlocked = false);
        timer.cancel();
        _secondsLeft = _seconds;
      }
    });
  }

  @override
  void initState() {
    setState(() => _secondsLeft = _seconds);
    super.initState();
  }

  @override
  void dispose() {
    _resetBlockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TODO: Replace with arb
                  Text("Password reset", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  // TODO: Replace with arb
                  const Text("Enter your email address to receive a link to reset your password."),
                  const SizedBox(height: 16),
                  TextField(
                    // TODO: Replace with arb
                    decoration: const InputDecoration(label: Text("Email"), floatingLabelBehavior: FloatingLabelBehavior.auto),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _sendButtonBlocked ? null : () => _sendPasswordResetEmail(_emailController.text),
                    // TODO: Replace with arb
                    child: Text(_sendButtonBlocked ? "Wait $_secondsLeft seconds" : "Send link"),
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
