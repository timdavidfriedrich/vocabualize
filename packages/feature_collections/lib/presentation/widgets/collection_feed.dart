import 'package:core/theme/spacing.dart';
import 'package:feature_collections/presentation/collection_bloc.dart';
import 'package:feature_collections/presentation/collection_event.dart';
import 'package:feature_collections/presentation/collection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_info_dialog.dart';
import 'package:shared/presentation/widgets/vocabulary_search_view.dart';
import 'package:shared/presentation/widgets/vocabulary_tile.dart';

class const CollectionFeed({
  super.key,
  required final bool _showsNoResults,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      CollectionBloc,
      CollectionState,
      ({List<Vocabulary> vocabularies, bool hasMore, LanguageSetup? setup})
    >(
      selector: (state) => switch (state) {
        CollectionLoaded(:final vocabularies, :final feedLimit, :final setup) => (
          vocabularies: vocabularies,
          hasMore: vocabularies.length >= feedLimit,
          setup: setup,
        ),
        CollectionLoading() ||
        CollectionClosed() ||
        CollectionFailure() => (vocabularies: const [], hasMore: false, setup: null),
      },
      builder: (context, feed) => switch (feed) {
        (vocabularies: [], hasMore: false, setup: _) when _showsNoResults =>
          const SliverToBoxAdapter(child: VocabularySearchEmpty()),
        (setup: null, vocabularies: _, hasMore: _) => const SliverToBoxAdapter(),
        (:final setup?, vocabularies: _, hasMore: _) => SliverList.builder(
          itemCount: feed.vocabularies.length + (feed.hasMore ? 1 : 0),
          itemBuilder: (_, index) => switch (feed.vocabularies.elementAtOrNull(index)) {
            final vocabulary? => VocabularyTile(
              key: ValueKey(vocabulary.id),
              vocabulary: vocabulary,
              language: setup.selected,
              mainLanguage: setup.main,
              onTap: () => _showInfo(context, vocabulary),
              onLongPress: () => context.pushEditVocabularyDetails(vocabularyId: vocabulary.id),
              onSpeak: () => context.read<CollectionBloc>().add(
                CollectionVocabularySpeakRequested(vocabulary: vocabulary),
              ),
            ),
            null => const _FeedEndLoader(),
          },
        ),
      },
    );
  }

  void _showInfo(BuildContext context, Vocabulary vocabulary) {
    final bloc = context.read<CollectionBloc>();
    if (bloc.state case CollectionLoaded(:final setup, :final tags)) {
      showVocabularyInfoDialog(
        context,
        vocabulary: vocabulary,
        language: setup.selected,
        mainLanguage: setup.main,
        tags: tags,
        onSpeak: () => bloc.add(CollectionVocabularySpeakRequested(vocabulary: vocabulary)),
        onEdit: () => context.pushEditVocabularyDetails(vocabularyId: vocabulary.id),
        onPhotographerOpened: (url) => bloc.add(CollectionPhotographerLinkOpened(url: url)),
      );
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
