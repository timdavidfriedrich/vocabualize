import 'package:log/log.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/models/app_user.dart';
import 'package:vocabualize/features/core/services/data/cloud_service.dart';
import 'package:vocabualize/features/core/streams/user_stream.dart';
import 'package:vocabualize/features/home/screens/home_screen.dart';
import 'package:vocabualize/features/onboarding/screens/verify_screen.dart';
import 'package:vocabualize/features/onboarding/screens/welcome_screen.dart';

class Root extends StatelessWidget {
  static const routeName = "/";
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: UserStream.instance.stream,
      builder: (context, snapshot) {
        Log.debug("userStream is ${snapshot.connectionState.name} with data: ${snapshot.data}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData) {
          return const WelcomeScreen();
        }
        AppUser.instance = snapshot.data!;
        if (AppUser.instance == AppUser.empty()) return const WelcomeScreen();
        if (!AppUser.instance.verified) return const VerifyScreen();
        CloudService.instance.loadData();
        return const HomeScreen();
      },
    );
  }
}
