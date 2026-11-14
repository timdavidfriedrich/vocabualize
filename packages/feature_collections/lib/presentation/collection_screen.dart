import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_collections/presentation/collection_bloc.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:feature_collections/presentation/widgets/collection_feed.dart';
import 'package:feature_collections/presentation/widgets/collection_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/vocabulary_search_view.dart';

class const CollectionScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CollectionBloc, CollectionState>(
          listenWhen: (previous, current) => current is CollectionClosed,
          listener: (context, state) => context.closeScreen(),
        ),
        BlocListener<CollectionBloc, CollectionState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (CollectionLoaded(error: null), CollectionLoaded(error: AppError())) => true,
            _ => false,
          },
          listener: (context, state) {
            if (state case CollectionLoaded(error: final error?)) {
              context.showToast(error.toMessage(context));
            }
          },
        ),
      ],
      child: BlocBuilder<CollectionBloc, CollectionState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state) => switch (state) {
          CollectionLoading() || CollectionClosed() => const LoadingScreen(),
          CollectionFailure(:final error) => _FailureScreen(error: error),
          CollectionLoaded() => const _ContentScreen(),
        },
      ),
    );
  }
}

class const _ContentScreen() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isSearching = useState(false);
    void closeSearch() {
      isSearching.value = false;
      context.read<CollectionBloc>().add(
        const CollectionFilterChanged(filter: emptyVocabularyFilter),
      );
    }

    return PopScope(
      canPop: !isSearching.value,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) closeSearch();
      },
      child: Stack(
        children: [
          Offstage(
            offstage: isSearching.value,
            child: CollectionOverview(onSearchOpened: () => isSearching.value = true),
          ),
          if (isSearching.value) Scaffold(body: _SearchView(onClosed: closeSearch)),
        ],
      ),
    );
  }
}

class const _SearchView({
  required final VoidCallback _onClosed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CollectionBloc, CollectionState, VocabularyFilter>(
      selector: (state) => switch (state) {
        CollectionLoading(:final filter) || CollectionLoaded(:final filter) => filter,
        CollectionClosed() || CollectionFailure() => emptyVocabularyFilter,
      },
      builder: (context, filter) => VocabularySearchView(
        filter: filter,
        onFilterChanged: (filter) =>
            context.read<CollectionBloc>().add(CollectionFilterChanged(filter: filter)),
        onClosed: _onClosed,
        results: const CollectionFeed(showsNoResults: true),
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
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Text(_error.toMessage(context), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
