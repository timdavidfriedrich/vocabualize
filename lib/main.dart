import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabualize/config/themes/themeConfig.dart';
import 'package:vocabualize/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return const ThemeHandler(home: Home());
  }
}
