import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/practise/screens/practise.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VocabularyProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => ActiveProvider()),
      ],
      child: MaterialApp(
        theme: ThemeConfig.light(context),
        darkTheme: ThemeConfig.dark(context),
        //showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        navigatorKey: Keys.navigatorState,
        initialRoute: "/",
        routes: {
          "/": (context) => const Home(),
          "/practise": (context) => const Practise(),
        },
      ),
    );
  }
}
