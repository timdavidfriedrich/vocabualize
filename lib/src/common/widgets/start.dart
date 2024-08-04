import 'package:log/log.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/models/app_user.dart';
import 'package:vocabualize/src/common/services/data/cloud_service.dart';
import 'package:vocabualize/src/common/streams/user_stream.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/verify_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/welcome_screen.dart';

class Start extends StatelessWidget {
  static const routeName = "/";
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: UserStream.instance.stream,
      builder: (context, snapshot) {
        Log.hint("User stream is ${snapshot.connectionState.name} with user: ${snapshot.data?.name}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const WelcomeScreen();
        }
        AppUser.instance = snapshot.data!;
        if (AppUser.instance == AppUser.empty()) {
          return const WelcomeScreen();
        }
        if (!AppUser.instance.verified) {
          return const VerifyScreen();
        }
        CloudService.instance.loadData();
        return const HomeScreen();
      },
    );
  }
}
