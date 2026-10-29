import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_collections/presentation/collection_bloc.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:feature_collections/presentation/widgets/edit_collection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/delete_vocabulary_dialog.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/practice_button.dart';
import 'package:shared/presentation/widgets/vocabulary_info_dialog.dart';
import 'package:shared/presentation/widgets/vocabulary_search_view.dart';
import 'package:shared/presentation/widgets/vocabulary_tile.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.xxl);
const _scrollEndSpacing = Spacing.xxxxl * 2;

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
            child: _Overview(onSearchOpened: () => isSearching.value = true),
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
        results: const _Feed(showsNoResults: true),
      ),
    );
  }
}

class const _Overview({
  required final VoidCallback _onSearchOpened,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<CollectionBloc, CollectionState, String>(
          selector: (state) => switch (state) {
            CollectionLoaded(:final tag) => tag.name,
            _ => "",
          },
          builder: (context, name) => Text(name, style: context.t.headlineSmall),
        ),
        actions: [
          IconButton(
            onPressed: _onSearchOpened,
            tooltip: context.s.vocabularySearchTooltip,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: () => _edit(context),
            icon: const Icon(Icons.edit_rounded),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: _pagePadding,
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: Spacing.m),
                      BlocSelector<CollectionBloc, CollectionState, ({String tagId, int due})?>(
                        selector: (state) => switch (state) {
                          CollectionLoaded(:final tag, :final dueCount) => (
                            tagId: tag.id,
                            due: dueCount,
                          ),
                          _ => null,
                        },
                        builder: (context, practice) => switch (practice) {
                          final practice? => SizedBox(
                            width: double.infinity,
                            child: PracticeButton(dueCount: practice.due, tagId: practice.tagId),
                          ),
                          null => const SizedBox.shrink(),
                        },
                      ),
                      const SizedBox(height: Spacing.m),
                    ],
                  ),
                ),
                const _Feed(showsNoResults: false),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: _scrollEndSpacing)),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context) async {
    final bloc = context.read<CollectionBloc>();
    final name = switch (bloc.state) {
      CollectionLoaded(:final tag) => tag.name,
      _ => null,
    };
    if (name == null) return;
    final edit = await requestsCollectionEdit(context, name: name);
    if (!context.mounted) return;
    switch (edit) {
      case CollectionRename(:final name):
        bloc.add(CollectionRenamed(name: name));
      case CollectionDelete():
        if (await confirmsCollectionDelete(context)) bloc.add(const CollectionDeleteRequested());
      case null:
        return;
    }
  }
}

class const _Feed({
  required final bool _showsNoResults,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      CollectionBloc,
      CollectionState,
      ({List<Vocabulary> vocabularies, bool hasMore})
    >(
      selector: (state) => switch (state) {
        CollectionLoaded(:final vocabularies, :final feedLimit) => (
          vocabularies: vocabularies,
          hasMore: vocabularies.length >= feedLimit,
        ),
        _ => (vocabularies: const [], hasMore: false),
      },
      builder: (context, feed) => switch (feed) {
        (vocabularies: [], hasMore: false) when _showsNoResults => const SliverToBoxAdapter(
          child: VocabularySearchEmpty(),
        ),
        _ => SliverList.builder(
          itemCount: feed.vocabularies.length + (feed.hasMore ? 1 : 0),
          itemBuilder: (_, index) => switch (feed.vocabularies.elementAtOrNull(index)) {
            final vocabulary? => VocabularyTile(
              key: ValueKey(vocabulary.id),
              vocabulary: vocabulary,
              onTap: () => _showInfo(context, vocabulary),
              onSpeak: () => context.read<CollectionBloc>().add(
                CollectionVocabularySpeakRequested(vocabulary: vocabulary),
              ),
              onEdit: () => context.pushEditVocabularyDetails(vocabularyId: vocabulary.id),
              onDelete: () => _confirmDelete(context, vocabulary),
            ),
            null => const _FeedEndLoader(),
          },
        ),
      },
    );
  }

  void _showInfo(BuildContext context, Vocabulary vocabulary) {
    final bloc = context.read<CollectionBloc>();
    showVocabularyInfoDialog(
      context,
      vocabulary: vocabulary,
      tags: switch (bloc.state) {
        CollectionLoaded(:final tags) => tags,
        _ => const [],
      },
      onSpeak: () => bloc.add(CollectionVocabularySpeakRequested(vocabulary: vocabulary)),
      onEdit: () => context.pushEditVocabularyDetails(vocabularyId: vocabulary.id),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Vocabulary vocabulary) async {
    final bloc = context.read<CollectionBloc>();
    if (await confirmsVocabularyDelete(context, vocabulary)) {
      bloc.add(CollectionVocabularyDeleteRequested(vocabularyId: vocabulary.id));
    }
  }
}

class const _FeedEndLoader() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CollectionBloc>().add(const CollectionFeedEndReached());
      return null;
    }, const []);
    return const Padding(
      padding: EdgeInsets.all(Spacing.m),
      child: Center(child: CircularProgressIndicator()),
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
