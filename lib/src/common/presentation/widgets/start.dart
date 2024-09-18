import 'package:log/log.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/domain/usecases/authentication/get_current_user_use_case.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/verify_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/welcome_screen.dart';

class Start extends StatelessWidget {
  static const routeName = "/";
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final getCurrentUser = sl.get<GetCurrentUserUseCase>();

    return StreamBuilder<AppUser?>(
      stream: getCurrentUser(),
      builder: (context, snapshot) {
        Log.hint("User stream is ${snapshot.connectionState.name} with user: ${snapshot.data?.name}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          //return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData) {
          //return const WelcomeScreen();
        }
        final currentUser = snapshot.data;
        if (currentUser == null) {
          return const WelcomeScreen();
        }
        if (!currentUser.verified) {
          return const VerifyScreen();
        }
        return const HomeScreen();
      },
    );
  }
}
