import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/theme_config.dart';
import 'package:vocabualize/screens/home.dart';
import 'package:vocabualize/utils/providers/active_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/providers/lang_provider.dart';

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
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => VocProv()),
      ChangeNotifierProvider(create: (context) => LangProv()),
      ChangeNotifierProvider(create: (context) => ActiveProv()),
    ], child: const ThemeHandler(home: Home()));
  }
}
