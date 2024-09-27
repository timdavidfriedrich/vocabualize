import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/features/collections/screens/collection_screen.dart';
import 'package:vocabualize/src/common/presentation/widgets/start.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/forgot_password_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/sign_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/select_language_screen.dart';
import 'package:vocabualize/src/features/onboarding/screens/welcome_screen.dart';
import 'package:vocabualize/src/features/practise/screens/practise_screen.dart';
import 'package:vocabualize/src/features/record/providers/active_provider.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/reports/screens/report_screen.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/src/features/settings/screens/choose_language_screen.dart';
import 'package:vocabualize/src/features/settings/screens/settings_screen.dart';
import 'package:vocabualize/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Log.hint("App is starting...");
  runApp(const Vocabualize());
}

class Vocabualize extends StatelessWidget {
  const Vocabualize({super.key});
  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (context) => ActiveProvider()),
        provider.ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('de', ''),
            Locale('es', ''),
          ],
          theme: ThemeConfig.light(context),
          darkTheme: ThemeConfig.dark(context),
          debugShowCheckedModeBanner: false,
          navigatorKey: Global.navigatorState,
          initialRoute: Start.routeName,
          routes: {
            Start.routeName: (context) => const Start(),
            WelcomeScreen.routeName: (context) => const WelcomeScreen(),
            SignScreen.routeName: (context) => const SignScreen(),
            ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
            SelectLanguageScreen.routeName: (context) => const SelectLanguageScreen(),
            ChooseLanguageScreen.routeName: (context) => const ChooseLanguageScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            PractiseScreen.routeName: (context) => const PractiseScreen(),
            DetailsScreen.routeName: (context) => const DetailsScreen(),
            CollectionScreen.routeName: (context) => const CollectionScreen(),
            ReportScreen.routeName: (context) => const ReportScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
