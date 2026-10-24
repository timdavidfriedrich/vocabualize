import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_screen.dart';
import 'package:feature_gate/presentation/splash/splash_screen.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_screen.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_screen.dart';
import 'package:feature_welcome/presentation/welcome_bloc.dart';
import 'package:feature_welcome/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:vocabualize/src/di/service_locator.dart';

@lazySingleton
class NavigationRouter(
  final AccountRepository _accountRepository,
) {
  late final KaiselRouterConfig<AppRoute> config = KaiselRouterConfig<AppRoute>(
    initial: const Splash(),
    builder: (context, route) => _AppPage(route: route),
  );

  StreamSubscription<AppResult<AuthStatus>>? _authStatusSubscription;

  @PostConstruct()
  void listenToAuthStatus() {
    _authStatusSubscription ??= _accountRepository.watchAuthStatus().listen(_onAuthStatus);
  }

  void _onAuthStatus(AppResult<AuthStatus> result) {
    final router = config.router;
    final isOnEntryRoute = switch (router.current) {
      Splash() || Welcome() => true,
      _ => false,
    };
    final target = switch (result) {
      Success(data: AuthUnknown()) => null,
      Success(data: AuthUnauthenticated()) || Failure() => const <AppRoute>[Welcome()],
      Success(data: AuthAuthenticated()) when isOnEntryRoute => const <AppRoute>[Home()],
      Success(data: AuthAuthenticated()) => null,
    };
    if (target != null) unawaited(router.set(target));
  }
}

class const _AppPage({
  required final AppRoute _route,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => switch (_route) {
    Splash() => const SplashScreen(),
    Welcome() => BlocProvider(
      create: (_) => sl<WelcomeBloc>(),
      child: const WelcomeScreen(),
    ),
    Home() => BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: const HomeScreen(),
    ),
    VocabularyDetails() => BlocProvider(
      create: (_) => sl<DetailsBloc>(),
      child: const DetailsScreen(),
    ),
    Settings() => BlocProvider(
      create: (_) => sl<SettingsBloc>()..add(const SettingsStarted()),
      child: const SettingsScreen(),
    ),
  };
}
