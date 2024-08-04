import 'package:log/log.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/data/data_sources/authentication_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/app_user.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/verify_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/welcome_screen.dart';

class Start extends StatelessWidget {
  static const routeName = "/";
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: AuthenticationDataSource.instance.stream,
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
        RemoteDatabaseDataSource.instance.loadData();
        return const HomeScreen();
      },
    );
  }
}
