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
import 'package:feature_languages/presentation/language_words/language_words_bloc.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_screen.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_screen.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_screen.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_bloc.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_event.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_screen.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_bloc.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_screen.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/practice/practice_screen.dart';
import 'package:feature_report/presentation/feedback_bloc.dart';
import 'package:feature_report/presentation/feedback_screen.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/scan_screen.dart';
import 'package:feature_settings/presentation/settings_bloc.dart';
import 'package:feature_settings/presentation/settings_event.dart';
import 'package:feature_settings/presentation/settings_screen.dart';
import 'package:feature_welcome/presentation/welcome/welcome_bloc.dart';
import 'package:feature_welcome/presentation/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaisel/kaisel.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/domain/entities/auth_status.dart';
import 'package:shared/domain/entities/data_readiness.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/account_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/sync_repository.dart';
import 'package:shared/presentation/navigation/routes.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:vocabualize/src/di/service_locator.dart';

typedef _EntryState = (
  AppResult<AuthStatus>,
  AppResult<DataReadiness>?,
  AppResult<LanguageSetup?>?,
);

@lazySingleton
class NavigationRouter(
  final AccountRepository _accountRepository,
  final SyncRepository _syncRepository,
  final LanguageRepository _languageRepository,
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
        Success(data: DataReady()) => _languageRepository.watchLanguageSetup().map(
          (languageSetup) => (authStatus, readiness, languageSetup),
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
      Loading() || Welcome() || WaitForData() || LanguageOnboarding() => true,
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
        const LanguageOnboarding(),
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
    LanguageOnboarding() => BlocProvider(
      create: (_) => sl<LanguageOnboardingBloc>()..add(const LanguageOnboardingStarted()),
      child: const LanguageOnboardingScreen(),
    ),
    Languages() => BlocProvider(
      create: (_) => sl<LanguagesBloc>()..add(const LanguagesStarted()),
      child: const LanguagesScreen(),
    ),
    LearnedLanguageDetails(:final language) => BlocProvider(
      create: (_) => sl<LearnedLanguageBloc>()..add(LearnedLanguageStarted(language: language)),
      child: LearnedLanguageScreen(language: language),
    ),
    LanguageWords(:final language, :final isAdding) => BlocProvider(
      create: (_) =>
          sl<LanguageWordsBloc>()
            ..add(LanguageWordsStarted(language: language, isAdding: isAdding)),
      child: LanguageWordsScreen(language: language, isAdding: isAdding),
    ),
    Home() => BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: const HomeScreen(),
    ),
    NewVocabularyDetails(:final text, :final language, :final photo, context: final labelContext) =>
      BlocProvider(
        create: (_) => sl<DetailsBloc>()
          ..add(
            DetailsNewStarted(
              text: text,
              language: language,
              photo: photo,
              context: labelContext,
            ),
          ),
        child: const DetailsScreen(),
      ),
    Scan() => BlocProvider(
      create: (_) => sl<ScanBloc>()..add(const ScanStarted()),
      child: const ScanScreen(),
    ),
    EditVocabularyDetails(:final vocabularyId) => BlocProvider(
      create: (_) => sl<DetailsBloc>()..add(DetailsEditStarted(vocabularyId: vocabularyId)),
      child: const DetailsScreen(),
    ),
    Practice(:final tagId, :final isCustom) => BlocProvider(
      create: (_) =>
          sl<PracticeBloc>()
            ..add(isCustom ? const PracticeCustomStarted() : PracticeStarted(tagId: tagId)),
      child: const PracticeScreen(),
    ),
    CustomPractice(:final tagId) => BlocProvider(
      create: (_) => sl<CustomPracticeBloc>()..add(CustomPracticeStarted(tagId: tagId)),
      child: const CustomPracticeScreen(),
    ),
    Collection(:final tagId) => BlocProvider(
      create: (_) => sl<CollectionBloc>()..add(CollectionStarted(tagId: tagId)),
      child: const CollectionScreen(),
    ),
    FeedbackForm() => BlocProvider(
      create: (_) => sl<FeedbackBloc>(),
      child: const FeedbackScreen(),
    ),
    Settings() => BlocProvider(
      create: (_) => sl<SettingsBloc>()..add(const SettingsStarted()),
      child: const SettingsScreen(),
    ),
  };
}
