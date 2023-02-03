import 'package:firebase_core/firebase_core.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/features/collections/screens/collection_screen.dart';
import 'package:vocabualize/features/home/screens/home_screen.dart';
import 'package:vocabualize/features/practise/screens/practise_screen.dart';
import 'package:vocabualize/features/profile/screens/profile_screen.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/details/screens/details_screen.dart';
import 'package:vocabualize/features/core/services/speech.dart';
import 'package:vocabualize/features/reports/screens/report_screen.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  var speech = Speech.instance;
  await speech.init();

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
        //showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        navigatorKey: Global.navigatorState,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          PractiseScreen.routeName: (context) => const PractiseScreen(),
          DetailsScreen.routeName: (context) => const DetailsScreen(),
          CollectionScreen.routeName: (context) => const CollectionScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          ReportScreen.routeName: (context) => const ReportScreen(),
        },
      ),
    );
  }
}
