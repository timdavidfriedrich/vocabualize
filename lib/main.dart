import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';

import 'package:vocabualize/src/di/service_locator.dart';
import 'package:vocabualize/src/navigation/navigation_router.dart';
import 'package:vocabualize/src/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}

class const App({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: sl<NavigationRouter>().router,
      onGenerateTitle: (context) => context.s.appTitle,
      theme: AppTheme.dark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
