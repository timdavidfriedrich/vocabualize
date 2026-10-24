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
import 'package:feature_welcome/presentation/language_selection/language_selection_bloc.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_event.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_screen.dart';
import 'package:feature_welcome/presentation/welcome/welcome_bloc.dart';
import 'package:feature_welcome/presentation/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/sync_status.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/sync_repository.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:vocabualize/src/di/service_locator.dart';

typedef _EntryState = (AppResult<AuthStatus>, AppResult<LanguagePair?>?, SyncStatus?);

@lazySingleton
class NavigationRouter(
  final AccountRepository _accountRepository,
  final SettingsRepository _settingsRepository,
  final SyncRepository _syncRepository,
) {
  late final KaiselRouterConfig<AppRoute> config = KaiselRouterConfig<AppRoute>(
    initial: const Splash(),
    builder: (context, route) => _AppPage(route: route),
  );

  StreamSubscription<_EntryState>? _entryStateSubscription;

  @PostConstruct()
  void listenToEntryState() {
    _entryStateSubscription ??= _accountRepository
        .watchAuthStatus()
        .switchMap(_withLanguagePair)
        .listen(_onEntryState);
  }

  Stream<_EntryState> _withLanguagePair(AppResult<AuthStatus> authStatus) => switch (authStatus) {
    Success(data: AuthAuthenticated()) => _settingsRepository.watchLanguagePair().switchMap(
      (languagePair) => switch (languagePair) {
        Success(data: null) => _syncRepository.watchSyncStatus().asyncMap((result) async {
          final syncStatus = switch (result) {
            Success(:final data) => data,
            Failure() => SyncStatus.offline,
          };
          return switch (syncStatus) {
            SyncStatus.disabled || SyncStatus.connecting => (authStatus, languagePair, syncStatus),
            _ => (authStatus, await _settingsRepository.readLanguagePair(), syncStatus),
          };
        }),
        Success() || Failure() => Stream.value((authStatus, languagePair, null)),
      },
    ),
    Success() || Failure() => Stream.value((authStatus, null, null)),
  };

  void _onEntryState(_EntryState state) {
    final router = config.router;
    final current = router.current;
    final isOnEntryRoute = switch (current) {
      Splash() || Welcome() || LanguageSelection(isOnboarding: true) => true,
      _ => false,
    };
    final target = switch (state) {
      (Success(data: AuthUnknown()), _, _) => null,
      (Success(data: AuthUnauthenticated()) || Failure(), _, _) => const Welcome(),
      (Success(data: AuthAuthenticated()), Success(data: _?), _) when isOnEntryRoute => const Home(),
      (
        Success(data: AuthAuthenticated(account: GoogleAccount())),
        Success(data: null),
        SyncStatus.disabled || SyncStatus.connecting,
      ) =>
        null,
      (Success(data: AuthAuthenticated()), Success(data: null), _) when isOnEntryRoute =>
        const LanguageSelection(isOnboarding: true),
      (Success(data: AuthAuthenticated()), _, _) => null,
    };
    if (target != null && target != current) unawaited(router.set([target]));
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
    LanguageSelection(:final isOnboarding) => BlocProvider(
      create: (_) => sl<LanguageSelectionBloc>()..add(const LanguageSelectionStarted()),
      child: LanguageSelectionScreen(isOnboarding: isOnboarding),
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
