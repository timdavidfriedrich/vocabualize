import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/extensions/home_context_extensions.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_search_view.dart';
import 'package:shared/presentation/widgets/vocabulary_tile.dart';

class const HomeFeed({
  super.key,
  required final bool _showsNoResults,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      HomeBloc,
      HomeState,
      ({List<Vocabulary> vocabularies, bool hasMore, LanguageSetup? setup})
    >(
      selector: (state) => switch (state) {
        HomeLoaded(:final vocabularies, :final feedLimit, :final setup) => (
          vocabularies: vocabularies,
          hasMore: vocabularies.length >= feedLimit,
          setup: setup,
        ),
        HomeLoading() || HomeFailure() => (vocabularies: const [], hasMore: false, setup: null),
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
              onTap: () => context.showVocabularyInfo(vocabulary),
              onLongPress: () => context.pushEditVocabularyDetails(vocabularyId: vocabulary.id),
              onSpeak: () => context.speakVocabulary(vocabulary),
            ),
            null => const _FeedEndLoader(),
          },
        ),
      },
    );
  }
}

class const _FeedEndLoader() extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<HomeBloc>().add(const HomeFeedEndReached());
      return null;
    }, const []);
    return const Padding(
      padding: EdgeInsets.all(Spacing.m),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
