import 'dart:async';

import 'package:feature_gate/presentation/gate/gate_cubit.dart';
import 'package:feature_gate/presentation/gate/gate_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/language_pair/language_pair_cubit.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/reminders/reminder_cubit.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';

import 'package:vocabualize/src/di/service_locator.dart';
import 'package:vocabualize/src/navigation/navigation_router.dart';
import 'package:vocabualize/src/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  unawaited(sl<AccountRepository>().restoreAuthStatus());
  runApp(const App());
}

class const App({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SyncStatusCubit>()..start()),
        BlocProvider(create: (_) => sl<GateCubit>()..start()),
        BlocProvider(create: (_) => sl<LanguagePairCubit>()..start()),
        BlocProvider(create: (_) => sl<ConnectivityCubit>()..start()),
        BlocProvider(create: (_) => sl<PreferencesCubit>()..start()),
        BlocProvider(lazy: false, create: (_) => sl<ReminderCubit>()..start()),
      ],
      child: MaterialApp.router(
        routerConfig: sl<NavigationRouter>().config,
        builder: (context, child) => GateOverlay(child: child ?? const SizedBox.shrink()),
        onGenerateTitle: (context) => context.s.appTitle,
        theme: AppTheme.dark,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
