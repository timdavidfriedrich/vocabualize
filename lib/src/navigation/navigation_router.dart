import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:feature_collections/presentation/collection_bloc.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_screen.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_screen.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_cubit.dart';
import 'package:feature_gate/presentation/wait_for_data/wait_for_data_screen.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_screen.dart';
import 'package:feature_practice/presentation/practice_bloc.dart';
import 'package:feature_practice/presentation/practice_event.dart';
import 'package:feature_practice/presentation/practice_screen.dart';
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
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/settings_repository.dart';
import 'package:shared/domain/repositories/sync_repository.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:vocabualize/src/di/service_locator.dart';

typedef _EntryState = (AppResult<AuthStatus>, AppResult<DataReadiness>?, AppResult<LanguagePair?>?);

@lazySingleton
class NavigationRouter(
  final AccountRepository _accountRepository,
  final SyncRepository _syncRepository,
  final SettingsRepository _settingsRepository,
) {
  late final KaiselRouterConfig<AppRoute> config = KaiselRouterConfig<AppRoute>(
    initial: const Loading(),
    builder: (context, route) => _AppPage(route: route),
  );

  StreamSubscription<_EntryState>? _entryStateSubscription;

  @PostConstruct()
  void listenToEntryState() {
    _entryStateSubscription ??= _accountRepository
        .watchAuthStatus()
        .switchMap(_withDataReadiness)
        .listen(_onEntryState);
  }

  Stream<_EntryState> _withDataReadiness(AppResult<AuthStatus> authStatus) => switch (authStatus) {
    Success(data: AuthAuthenticated()) => _syncRepository.watchDataReadiness().switchMap(
      (readiness) => switch (readiness) {
        Success(data: DataReady()) => _settingsRepository.watchLanguagePair().map(
          (languagePair) => (authStatus, readiness, languagePair),
        ),
        Success() || Failure() => Stream.value((authStatus, readiness, null)),
      },
    ),
    Success() || Failure() => Stream.value((authStatus, null, null)),
  };

  void _onEntryState(_EntryState state) {
    final router = config.router;
    final current = router.current;
    final isOnEntryRoute = switch (current) {
      Loading() || Welcome() || WaitForData() || LanguageSelection(isOnboarding: true) => true,
      _ => false,
    };
    final target = switch (state) {
      (Success(data: AuthUnknown()), _, _) => null,
      (Success(data: AuthUnauthenticated()) || Failure(), _, _) => const Welcome(),
      (Success(data: AuthAuthenticated()), Success(data: DataDownloading()), _) => const Loading(),
      (Success(data: AuthAuthenticated()), Success(data: DataUnavailable(:final reason)), _) =>
        _waitForData(reason),
      (Success(data: AuthAuthenticated()), Failure(), _) => _waitForData(
        DataUnavailableReason.offline,
      ),
      (Success(data: AuthAuthenticated()), Success(data: DataReady()), Success(data: _?))
          when isOnEntryRoute =>
        const Home(),
      (Success(data: AuthAuthenticated()), Success(data: DataReady()), Success(data: null))
          when isOnEntryRoute =>
        const LanguageSelection(isOnboarding: true),
      (Success(data: AuthAuthenticated()), _, _) => null,
    };
    if (target != null && target != current) unawaited(router.set([target]));
  }

  WaitForData _waitForData(DataUnavailableReason reason) => switch (reason) {
    DataUnavailableReason.offline => const WaitForData(reason: DataUnavailableReason.offline),
    DataUnavailableReason.serverUnreachable => const WaitForData(
      reason: DataUnavailableReason.serverUnreachable,
    ),
    DataUnavailableReason.signInRequired => const WaitForData(
      reason: DataUnavailableReason.signInRequired,
    ),
    DataUnavailableReason.updateRequired => const WaitForData(
      reason: DataUnavailableReason.updateRequired,
    ),
    DataUnavailableReason.syncFailed => const WaitForData(
      reason: DataUnavailableReason.syncFailed,
    ),
  };
}

class const _AppPage({
  required final AppRoute _route,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => switch (_route) {
    Loading() => const LoadingScreen(),
    WaitForData(:final reason) => BlocProvider(
      create: (_) => sl<WaitForDataCubit>(),
      child: WaitForDataScreen(reason: reason),
    ),
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
    NewVocabularyDetails(:final source) => BlocProvider(
      create: (_) => sl<DetailsBloc>()..add(DetailsNewStarted(source: source)),
      child: const DetailsScreen(),
    ),
    EditVocabularyDetails(:final vocabularyId) => BlocProvider(
      create: (_) => sl<DetailsBloc>()..add(DetailsEditStarted(vocabularyId: vocabularyId)),
      child: const DetailsScreen(),
    ),
    Practice(:final tagId) => BlocProvider(
      create: (_) => sl<PracticeBloc>()..add(PracticeStarted(tagId: tagId)),
      child: const PracticeScreen(),
    ),
    Collection(:final tagId) => BlocProvider(
      create: (_) => sl<CollectionBloc>()..add(CollectionStarted(tagId: tagId)),
      child: const CollectionScreen(),
    ),
    Settings() => BlocProvider(
      create: (_) => sl<SettingsBloc>()..add(const SettingsStarted()),
      child: const SettingsScreen(),
    ),
  };
}
