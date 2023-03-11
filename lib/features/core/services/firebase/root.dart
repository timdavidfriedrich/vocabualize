import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/home/screens/home_screen.dart';
import 'package:vocabualize/features/onboarding/screens/verify_screen.dart';
import 'package:vocabualize/features/onboarding/screens/welcome_screen.dart';

class Root extends StatelessWidget {
  static const routeName = "/";
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // stream: Provider.of<AuthProvider>(context).userChanges,
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          // only gets called once when auth state changes => manual check on verify screen necessary
          bool isEmailVerified = snapshot.data!.isAnonymous || snapshot.data!.emailVerified;
          return isEmailVerified ? const HomeScreen() : const VerifyScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
