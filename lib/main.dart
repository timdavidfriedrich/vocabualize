import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/collections/screens/collection_screen.dart';
import 'package:vocabualize/features/core/widgets/root.dart';
import 'package:vocabualize/features/core/services/notification_service.dart';
import 'package:vocabualize/features/core/services/text/speech_to_text_service.dart';
import 'package:vocabualize/features/home/screens/home_screen.dart';
import 'package:vocabualize/features/onboarding/screens/forgot_password_screen.dart';
import 'package:vocabualize/features/onboarding/screens/sign_screen.dart';
import 'package:vocabualize/features/onboarding/screens/select_language_screen.dart';
import 'package:vocabualize/features/onboarding/screens/welcome_screen.dart';
import 'package:vocabualize/features/practise/screens/practise_screen.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/details/screens/details_screen.dart';
import 'package:vocabualize/features/reports/screens/report_screen.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/screens/choose_language_screen.dart';
import 'package:vocabualize/features/settings/screens/settings_screen.dart';
import 'package:vocabualize/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService.instance.init();
  SpeechToTextService.instance.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Log.hint("App is starting...");
  runApp(const Vocabualize());
}

class Vocabualize extends StatelessWidget {
  const Vocabualize({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActiveProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => VocabularyProvider()),
      ],
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
        initialRoute: Root.routeName,
        routes: {
          Root.routeName: (context) => const Root(),
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
    );
  }
}
