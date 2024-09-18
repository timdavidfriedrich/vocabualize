import 'dart:async';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/usecases/authentication/send_verification_email_use_case.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _sendVerificationEmail = sl.get<SendVerificationEmailUseCase>();

  Timer? reloadTimer;
  bool _sendButtonBlocked = false;
  Timer? _blockTimer;
  final int _seconds = 60;
  late int _secondsLeft;

  void _startReloadTimer() async {
    setState(() => reloadTimer = Timer.periodic(const Duration(seconds: 3), (_) => _reload()));
  }

  void _reload() async {
    // await AuthService.instance.reloadUser().whenComplete(() {
    //   if (FirebaseAuth.instance.currentUser!.emailVerified) {
    //     reloadTimer?.cancel();
    //     Navigator.pushNamed(context, SelectLanguageScreen.routeName);
    //   }
    // });
  }

  void _resetBlockTimer() {
    _blockTimer?.cancel();
    setState(() => _secondsLeft = _seconds);
  }

  Future<void> _onSendVerificationEmailClick() async {
    _sendVerificationEmail();
    setState(() => _sendButtonBlocked = true);
    _blockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _secondsLeft -= 1);
      if (_secondsLeft == 0) {
        setState(() => _sendButtonBlocked = false);
        _resetBlockTimer();
      }
    });
  }

  @override
  void initState() {
    _resetBlockTimer();
    _startReloadTimer();
    super.initState();
  }

  @override
  void dispose() {
    reloadTimer?.cancel();
    _blockTimer?.cancel();
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
                    onPressed: _sendButtonBlocked ? null : () => _onSendVerificationEmailClick(),
                    // TODO: Replace with arb
                    child: Text(_sendButtonBlocked ? "Wait $_secondsLeft seconds" : "Resend verification email"),
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
