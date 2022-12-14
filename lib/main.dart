import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/practise/screens/practise.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/record/services/speech.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        theme: ThemeConfig.light(context),
        darkTheme: ThemeConfig.dark(context),
        //showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        navigatorKey: Keys.navigatorState,
        initialRoute: Home.routeName,
        routes: {
          Home.routeName: (context) => const Home(),
          Practise.routeName: (context) => const Practise(),
        },
      ),
    );
  }
}
