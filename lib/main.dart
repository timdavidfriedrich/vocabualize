import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/src/features/collections/presentation/screens/collection_screen.dart';
import 'package:vocabualize/src/common/presentation/widgets/start.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/forgot_password_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/sign_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/choose_languages_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:vocabualize/src/features/practise/presentation/screens/practise_screen.dart';
import 'package:vocabualize/src/features/record/presentation/providers/active_provider.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
import 'package:vocabualize/src/features/reports/presentation/screens/report_screen.dart';
import 'package:vocabualize/src/common/presentation/screens/language_picker_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/screens/settings_screen.dart';
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
            ChooseLanguagesScreen.routeName: (context) => const ChooseLanguagesScreen(),
            LanguagePickerScreen.routeName: (context) => const LanguagePickerScreen(),
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
