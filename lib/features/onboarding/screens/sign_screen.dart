import 'package:flutter/scheduler.dart';
import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/firebase/auth_service.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/onboarding/screens/forgot_password_screen.dart';
import 'package:vocabualize/features/onboarding/screens/welcome_screen.dart';
import 'package:vocabualize/features/onboarding/services/email_validator.dart';
import 'package:vocabualize/features/onboarding/services/sign_arguments.dart';
import 'package:vocabualize/features/onboarding/services/sign_type.dart';
import 'package:vocabualize/features/onboarding/widgets/passwords_dont_match_dialog.dart';

class SignScreen extends StatefulWidget {
  static const String routeName = "${WelcomeScreen.routeName}/Sign";
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late SignArguments arguments;
  SignType signType = SignType.none;

  String _email = "";
  String _password = "";
  String _repeatedPassword = "";
  bool _isEmailValid = false;
  bool _isPasswordObscured = true;

  void _signIn() {
    AuthService.signInWithEmailAndPassword(_email, _password);
    Navigator.pop(context);
  }

  void _signUp() {
    if (_password != _repeatedPassword) {
      Messenger.showStaticDialog(const PasswordsDontMatchDialog());
      return;
    }
    AuthService.createUserWithEmailAndPassword(_email, _password);
    Navigator.pop(context);
  }

  void _updateEmail(String email) {
    setState(() => _email = email);
  }

  void _checkIfEmailIsValid() {
    setState(() => _isEmailValid = EmailValidator.validate(_email));
  }

  void _updatePassword(String password) {
    setState(() => _password = password);
  }

  void _updateRepeatedPassword(String repeatedPassword) {
    setState(() => _repeatedPassword = repeatedPassword);
  }

  void _changePasswordVisibility() {
    setState(() => _isPasswordObscured = !_isPasswordObscured);
  }

  void _navigateToForgotPasswordScreen() {
    Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        arguments = (ModalRoute.of(context)!.settings.arguments as SignArguments);
        signType = arguments.signType;
      });
    });
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset(
                  signType == SignType.signIn ? AssetPath.mascotWaving : AssetPath.mascotHanging,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      // TODO: Replace with arb
                      signType == SignType.signIn ? "Great to see\nyou again!" : "Welcome!",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 48),
                    TextField(
                      // TODO: Replace with arb
                      decoration: const InputDecoration(label: Text("Email"), floatingLabelBehavior: FloatingLabelBehavior.auto),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {
                        _updateEmail(text);
                        _checkIfEmailIsValid();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        // TODO: Replace with arb
                        label: const Text("Password"),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        suffixIcon: _password.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () => _changePasswordVisibility(),
                                icon: Icon(_isPasswordObscured ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                              ),
                      ),
                      textInputAction: signType == SignType.signIn ? TextInputAction.done : TextInputAction.next,
                      obscureText: _isPasswordObscured,
                      onChanged: (text) => _updatePassword(text),
                    ),
                    const SizedBox(height: 16),
                    signType == SignType.signIn
                        ? Container()
                        : TextField(
                            decoration: const InputDecoration(
                              // TODO: Replace with arb
                              label: Text("Repeat Password"),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            obscureText: true,
                            onChanged: (text) => _updateRepeatedPassword(text),
                          ),
                    const SizedBox(height: 32),
                    signType == SignType.signIn
                        ? ElevatedButton(
                            onPressed: !_isEmailValid || _email.isEmpty || _password.isEmpty ? null : () => _signIn(),
                            // TODO: Replace with arb
                            child: const Text("Sign in"),
                          )
                        : ElevatedButton(
                            onPressed:
                                !_isEmailValid || _email.isEmpty || _password.isEmpty || _repeatedPassword.isEmpty ? null : () => _signUp(),
                            // TODO: Replace with arb
                            child: const Text("Sign up"),
                          ),
                    const SizedBox(height: 8),
                    signType == SignType.signIn
                        ? TextButton(
                            onPressed: () => _navigateToForgotPasswordScreen(),
                            child: Text(
                              // TODO: Replace with arb
                              "Forgot password?",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
