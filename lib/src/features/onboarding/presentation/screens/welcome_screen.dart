import 'package:flutter/material.dart';
import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/sign_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/choose_languages_screen.dart';
import 'package:vocabualize/src/features/onboarding/domain/entities/sign_type.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = "/Onboarding";
  const WelcomeScreen({super.key});

  void _navigateToSignIn(BuildContext context) {
    context.pushNamed(SignScreen.routeName, arguments: SignArguments(signType: SignType.signIn));
  }

  void _navigateToSignUp(BuildContext context) {
    context.pushNamed(SignScreen.routeName, arguments: SignArguments(signType: SignType.signUp));
  }

  void _continueAsGuest(BuildContext context) {
    context.pushNamed(ChooseLanguagesScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Text(
                  CommonConstants.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 24),
                Flexible(child: Image.asset(AssetPath.mascotIdle)),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => _navigateToSignIn(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                  // TODO: Replace with arb
                  child: Text("Login", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _navigateToSignUp(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                  // TODO: Replace with arb
                  child: Text("Register", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => _continueAsGuest(context),
                  style: OutlinedButton.styleFrom().copyWith(
                    side: WidgetStateProperty.all<BorderSide>(
                      BorderSide(width: 2, color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  // TODO: Replace with arb
                  child: Text("Continue as guest", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
