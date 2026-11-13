import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:feature_gate/presentation/gate/gate_cubit.dart';
import 'package:feature_gate/presentation/gate/gate_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/domain/entities/appearance_mode.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/presentation/account/account_cubit.dart';
import 'package:shared/presentation/connectivity/connectivity_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/appearance_mode_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/language_setup/language_setup_cubit.dart';
import 'package:shared/presentation/localization/generated/app_localizations.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/reminders/reminder_cubit.dart';
import 'package:shared/presentation/sync_status/sync_status_cubit.dart';
import 'package:shared/presentation/system_action/system_action_cubit.dart';
import 'package:shared/presentation/translation_fill/translation_fill_cubit.dart';
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
        BlocProvider(create: (_) => sl<AccountCubit>()..start()),
        BlocProvider(create: (_) => sl<SyncStatusCubit>()..start()),
        BlocProvider(create: (_) => sl<GateCubit>()..start()),
        BlocProvider(create: (_) => sl<LanguageSetupCubit>()..start()),
        BlocProvider(create: (_) => sl<ConnectivityCubit>()..start()),
        BlocProvider(create: (_) => sl<SystemActionCubit>()),
        BlocProvider(create: (_) => sl<PreferencesCubit>()..start()),
        BlocProvider(lazy: false, create: (_) => sl<ReminderCubit>()..start()),
        BlocProvider(lazy: false, create: (_) => sl<TranslationFillCubit>()..start()),
      ],
      child: BlocSelector<PreferencesCubit, Preferences, AppearanceMode>(
        selector: (preferences) => preferences.appearanceMode,
        builder: (context, appearanceMode) => MaterialApp.router(
          routerConfig: sl<NavigationRouter>().config,
          builder: (context, child) => _AppFrame(child: child ?? const SizedBox.shrink()),
          onGenerateTitle: (context) => context.s.appTitle,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: appearanceMode.toThemeMode(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}

class const _AppFrame({
  required final Widget _child,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useOnAppLifecycleStateChange((previous, current) {
      if (current == AppLifecycleState.resumed) context.read<TranslationFillCubit>().resume();
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: switch (Theme.of(context).brightness) {
        Brightness.dark => SystemUiOverlayStyle.light,
        Brightness.light => SystemUiOverlayStyle.dark,
      },
      child: BlocListener<SystemActionCubit, AppError?>(
        listener: (context, error) {
          if (error != null) context.showToast(error.toMessage(context));
        },
        child: GateOverlay(child: _child),
      ),
    );
  }
}
