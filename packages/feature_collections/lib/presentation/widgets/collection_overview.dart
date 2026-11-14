import 'package:core/theme/spacing.dart';
import 'package:feature_collections/presentation/collection_bloc.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:feature_collections/presentation/widgets/collection_feed.dart';
import 'package:feature_collections/presentation/widgets/delete_collection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/tag_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/collection_dialog.dart';
import 'package:shared/presentation/widgets/practice_button.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.xxl);
const _scrollEndSpacing = Spacing.xxxxxl;

class const CollectionOverview({
  super.key,
  required final VoidCallback _onSearchOpened,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<CollectionBloc, CollectionState, String>(
          selector: (state) => switch (state) {
            CollectionLoaded(:final tag) => tag.toLabel(),
            CollectionLoading() || CollectionClosed() || CollectionFailure() => "",
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
                      BlocSelector<CollectionBloc, CollectionState, ({String tagId, int count})?>(
                        selector: (state) => switch (state) {
                          CollectionLoaded(:final tag, :final practiceCount) => (
                            tagId: tag.id,
                            count: practiceCount,
                          ),
                          CollectionLoading() || CollectionClosed() || CollectionFailure() => null,
                        },
                        builder: (context, practice) => switch (practice) {
                          final practice? => PracticeButton(
                            count: practice.count,
                            tagId: practice.tagId,
                          ),
                          null => const SizedBox.shrink(),
                        },
                      ),
                      const _EmptyLanguageHint(),
                      const SizedBox(height: Spacing.m),
                    ],
                  ),
                ),
                const CollectionFeed(showsNoResults: false),
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
    if (bloc.state case CollectionLoaded(:final tag, :final tags)) {
      final edit = await requestsCollectionEdit(
        context,
        tag: tag,
        usedEmojis: [for (final tag in tags) ?tag.emoji],
      );
      if (!context.mounted) return;
      switch (edit) {
        case CollectionSaved(:final name, :final emoji):
          bloc.add(CollectionEdited(name: name, emoji: emoji));
        case CollectionDeleteChosen():
          if (await confirmsCollectionDelete(context)) bloc.add(const CollectionDeleteRequested());
        case null:
          return;
      }
    }
  }
}

class const _EmptyLanguageHint() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CollectionBloc, CollectionState, Language?>(
      selector: (state) => switch (state) {
        CollectionLoaded(
          vocabularies: [],
          :final tagWordCount,
          :final setup,
          :final filter,
        )
            when tagWordCount > 0 && filter == emptyVocabularyFilter =>
          setup.selected,
        CollectionLoading() ||
        CollectionLoaded() ||
        CollectionClosed() ||
        CollectionFailure() => null,
      },
      builder: (context, language) => switch (language) {
        final language? => Padding(
          padding: const EdgeInsets.only(top: Spacing.xl),
          child: Column(
            children: [
              Text(
                context.s.collectionEmptyLanguageMessage(language.toLabel(context)),
                style: context.t.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.m),
              TonalButton(
                onPressed: () => context.pushLanguageWords(language: language, isAdding: false),
                child: Text(context.s.homeChooseWordsButton),
              ),
            ],
          ),
        ),
        null => const SizedBox.shrink(),
      },
    );
  }
}
