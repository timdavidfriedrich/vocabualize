import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/collections_section.dart';
import 'package:feature_home/presentation/widgets/recent_vocabularies_section.dart';
import 'package:feature_home/presentation/widgets/record_fab.dart';
import 'package:feature_home/presentation/widgets/status_card.dart';
import 'package:feature_home/presentation/widgets/streak_chip.dart';
import 'package:feature_home/presentation/widgets/streak_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/delete_vocabulary_dialog.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/mascot.dart';
import 'package:shared/presentation/widgets/sync_status_icon.dart';
import 'package:shared/presentation/widgets/vocabulary_info_dialog.dart';
import 'package:shared/presentation/widgets/vocabulary_tile.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.xxl);
const _scrollEndSpacing = Spacing.xxxxl * 2;
const _mascotScreenHeightFactor = 0.4;

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
            previous.runtimeType != current.runtimeType || _isEmpty(previous) != _isEmpty(current),
        builder: (context, state) => switch (state) {
          HomeLoading() => const LoadingScreen(),
          HomeFailure(:final error) => _FailureScreen(error: error),
          HomeLoaded() when _isEmpty(state) => const _EmptyScreen(),
          HomeLoaded() => const _ContentScreen(),
        },
      ),
    );
  }
}

bool _isEmpty(HomeState state) => switch (state) {
  HomeLoaded(overview: VocabularyOverview(totalCount: 0), vocabularies: []) => true,
  _ => false,
};

class const _ContentScreen() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: const RecordFab(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSafeArea(
            left: false,
            right: false,
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverPadding(
                  padding: _pagePadding,
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: Spacing.xxl),
                        const _TitleRow(),
                        const SizedBox(height: Spacing.m),
                        BlocSelector<HomeBloc, HomeState, VocabularyOverview?>(
                          selector: (state) => switch (state) {
                            HomeLoaded(:final overview) => overview,
                            _ => null,
                          },
                          builder: (context, overview) => switch (overview) {
                            final overview? => StatusCard(overview: overview),
                            null => const SizedBox.shrink(),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const _RecentSection(),
                const _CollectionsRow(),
                SliverPadding(
                  padding: _pagePadding,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Spacing.xxl),
                            _SectionTitle(title: context.s.homeAllWordsTitle),
                            const SizedBox(height: Spacing.m),
                          ],
                        ),
                      ),
                      const _Feed(),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: _scrollEndSpacing)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _CollectionsRow() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<CollectionPreview>>(
      selector: (state) => switch (state) {
        HomeLoaded(:final collections) => collections,
        _ => const [],
      },
      builder: (context, collections) => SliverToBoxAdapter(
        child: collections.isEmpty
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Spacing.xxl),
                  Padding(
                    padding: _pagePadding,
                    child: _SectionTitle(title: context.s.homeCollectionsTitle),
                  ),
                  const SizedBox(height: Spacing.m),
                  CollectionsSection(collections: collections),
                ],
              ),
      ),
    );
  }
}

class const _RecentSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<Vocabulary>>(
      selector: (state) => switch (state) {
        HomeLoaded(:final recentVocabularies) => recentVocabularies,
        _ => const [],
      },
      builder: (context, recentVocabularies) => SliverToBoxAdapter(
        child: recentVocabularies.isEmpty
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Spacing.xxl),
                  Padding(
                    padding: _pagePadding,
                    child: _SectionTitle(title: context.s.homeNewWordsTitle),
                  ),
                  const SizedBox(height: Spacing.m),
                  RecentVocabulariesSection(
                    vocabularies: recentVocabularies,
                    onTap: (vocabulary) => _showInfo(context, vocabulary),
                  ),
                ],
              ),
      ),
    );
  }
}

class const _Feed() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, ({List<Vocabulary> vocabularies, bool hasMore})>(
      selector: (state) => switch (state) {
        HomeLoaded(:final vocabularies, :final feedLimit) => (
          vocabularies: vocabularies,
          hasMore: vocabularies.length >= feedLimit,
        ),
        _ => (vocabularies: const [], hasMore: false),
      },
      builder: (context, feed) => SliverList.builder(
        itemCount: feed.vocabularies.length + (feed.hasMore ? 1 : 0),
        itemBuilder: (_, index) => switch (feed.vocabularies.elementAtOrNull(index)) {
          final vocabulary? => VocabularyTile(
            key: ValueKey(vocabulary.id),
            vocabulary: vocabulary,
            onTap: () => _showInfo(context, vocabulary),
            onSpeak: () => _speak(context, vocabulary),
            onEdit: () => _edit(context, vocabulary),
            onDelete: () => _confirmDelete(context, vocabulary),
          ),
          null => const _FeedEndLoader(),
        },
      ),
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

class const _TitleRow() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(context.s.appTitle, style: context.t.headlineMedium),
          ),
        ),
        const SizedBox(width: Spacing.m),
        const SyncStatusIcon(),
        const _StreakButton(),
        IconButton(
          onPressed: context.pushSettings,
          tooltip: context.s.settingsTitle,
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
    );
  }
}

class const _StreakButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Streak?>(
      selector: (state) => switch (state) {
        HomeLoading(:final streak) || HomeLoaded(:final streak) => streak,
        HomeFailure() => null,
      },
      builder: (context, streak) => switch (streak) {
        final streak? => StreakChip(streak: streak, onPressed: () => showStreakSheet(context)),
        null => const SizedBox.shrink(),
      },
    );
  }
}

class const _SectionTitle({
  required final String _title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(_title, style: context.t.headlineSmall);
  }
}

class const _EmptyScreen() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: const RecordFab(),
      body: SafeArea(
        child: Padding(
          padding: _pagePadding,
          child: Column(
            children: [
              const SizedBox(height: Spacing.xxl),
              const _TitleRow(),
              const Spacer(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * _mascotScreenHeightFactor,
                child: const Mascot(pose: MascotPose.search),
              ),
              const Spacer(),
              Text(
                context.s.homeAddFirstWordMessage,
                style: context.t.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: _scrollEndSpacing),
            ],
          ),
        ),
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

void _showInfo(BuildContext context, Vocabulary vocabulary) {
  final bloc = context.read<HomeBloc>();
  showVocabularyInfoDialog(
    context,
    vocabulary: vocabulary,
    tags: switch (bloc.state) {
      HomeLoaded(:final collections) => [for (final collection in collections) collection.tag],
      _ => const [],
    },
    onSpeak: () => bloc.add(HomeVocabularySpeakRequested(vocabulary: vocabulary)),
    onEdit: () => _edit(context, vocabulary),
  );
}

void _edit(BuildContext context, Vocabulary vocabulary) {
  context.pushEditVocabularyDetails(vocabularyId: vocabulary.id);
}

void _speak(BuildContext context, Vocabulary vocabulary) {
  context.read<HomeBloc>().add(HomeVocabularySpeakRequested(vocabulary: vocabulary));
}

Future<void> _confirmDelete(BuildContext context, Vocabulary vocabulary) async {
  final bloc = context.read<HomeBloc>();
  if (await confirmsVocabularyDelete(context, vocabulary)) {
    bloc.add(HomeVocabularyDeleteRequested(vocabularyId: vocabulary.id));
  }
}
