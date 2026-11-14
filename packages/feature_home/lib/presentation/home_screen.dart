import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/home_app_bar.dart';
import 'package:feature_home/presentation/widgets/home_empty_screen.dart';
import 'package:feature_home/presentation/widgets/home_feed.dart';
import 'package:feature_home/presentation/widgets/home_overview.dart';
import 'package:feature_home/presentation/widgets/record_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/vocabulary_search_view.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.m);

class const HomeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (HomeLoaded(error: null), HomeLoaded(error: AppError())) => true,
        _ => false,
      },
      listener: (context, state) {
        if (state case HomeLoaded(error: final error?)) context.showToast(error.toMessage(context));
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType ||
            _screenOf(previous) != _screenOf(current),
        builder: (context, state) => switch (_screenOf(state)) {
          _HomeScreenKind.loading => const LoadingScreen(),
          _HomeScreenKind.failure => switch (state) {
            HomeFailure(:final error) => _FailureScreen(error: error),
            HomeLoading() || HomeLoaded() => const LoadingScreen(),
          },
          _HomeScreenKind.empty => const HomeEmptyScreen(),
          _HomeScreenKind.content => const _ContentScreen(),
        },
      ),
    );
  }
}

enum _HomeScreenKind { loading, failure, empty, content }

_HomeScreenKind _screenOf(HomeState state) => switch (state) {
  HomeLoading() => _HomeScreenKind.loading,
  HomeFailure() => _HomeScreenKind.failure,
  HomeLoaded(overview: VocabularyOverview(totalCount: 0), vocabularies: [], allWordsCount: 0) =>
    _HomeScreenKind.empty,
  HomeLoaded() => _HomeScreenKind.content,
};

class const _ContentScreen() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isSearching = useState(false);
    void closeSearch() {
      isSearching.value = false;
      context.read<HomeBloc>().add(const HomeFilterChanged(filter: emptyVocabularyFilter));
    }

    return PopScope(
      canPop: !isSearching.value,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) closeSearch();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: isSearching.value,
        appBar: isSearching.value ? null : const HomeAppBar(),
        floatingActionButton: isSearching.value ? null : const RecordFab(),
        body: Stack(
          children: [
            Offstage(
              offstage: isSearching.value,
              child: HomeOverview(onSearchOpened: () => isSearching.value = true),
            ),
            if (isSearching.value) _SearchView(onClosed: closeSearch),
          ],
        ),
      ),
    );
  }
}

class const _SearchView({
  required final VoidCallback _onClosed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, VocabularyFilter>(
      selector: (state) => switch (state) {
        HomeLoading(:final filter) || HomeLoaded(:final filter) => filter,
        HomeFailure() => emptyVocabularyFilter,
      },
      builder: (context, filter) => VocabularySearchView(
        filter: filter,
        onFilterChanged: (filter) =>
            context.read<HomeBloc>().add(HomeFilterChanged(filter: filter)),
        onClosed: _onClosed,
        results: const HomeFeed(showsNoResults: true),
      ),
    );
  }
}

class const _FailureScreen({
  required final AppError _error,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: _pagePadding,
          child: Center(child: Text(_error.toMessage(context), textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
