import 'package:core/error/app_error.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_event.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/collections_section.dart';
import 'package:feature_home/presentation/widgets/language_import_card.dart';
import 'package:feature_home/presentation/widgets/language_menu_button.dart';
import 'package:feature_home/presentation/widgets/recent_vocabularies_section.dart';
import 'package:feature_home/presentation/widgets/record_fab.dart';
import 'package:feature_home/presentation/widgets/status_card.dart';
import 'package:feature_home/presentation/widgets/streak_chip.dart';
import 'package:feature_home/presentation/widgets/streak_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/account.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/streak.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/presentation/account/account_cubit.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/account_status_avatar.dart';
import 'package:shared/presentation/widgets/loading_screen.dart';
import 'package:shared/presentation/widgets/mascot.dart';
import 'package:shared/presentation/widgets/vocabulary_info_dialog.dart';
import 'package:shared/presentation/widgets/vocabulary_search_view.dart';
import 'package:shared/presentation/widgets/vocabulary_tile.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.m);
const _scrollEndSpacing = Spacing.xxxxl * 2;
const _backdropWidthFactor = 0.77;
const _plusSymbol = "+";
const _searchingMascotAspectRatio = 0.756;
const _mascotHeightFactor = 0.944;
const _avatarRadius = Spacing.m;

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
          _HomeScreenKind.empty => const _EmptyScreen(),
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
        appBar: isSearching.value ? null : const _HomeAppBar(),
        floatingActionButton: isSearching.value ? null : const RecordFab(),
        body: Stack(
          children: [
            Offstage(
              offstage: isSearching.value,
              child: _Overview(onSearchOpened: () => isSearching.value = true),
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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverSafeArea(
          left: false,
          right: false,
          sliver: SliverMainAxisGroup(
            slivers: [
              const SliverPadding(
                padding: _pagePadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: Spacing.s),
                      _StatusArea(),
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
                          _AllWordsHeader(onSearchOpened: _onSearchOpened),
                          const SizedBox(height: Spacing.xs),
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
        ),
      ],
    );
  }
}

class const _CollectionsRow() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<CollectionPreview>>(
      selector: (state) => switch (state) {
        final HomeLoaded loaded when !loaded.isLanguageEmpty => loaded.collections,
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
    return BlocSelector<
      HomeBloc,
      HomeState,
      ({List<Vocabulary> vocabularies, LanguageSetup? setup})
    >(
      selector: (state) => switch (state) {
        HomeLoaded(:final recentVocabularies, :final setup) => (
          vocabularies: recentVocabularies,
          setup: setup,
        ),
        _ => (vocabularies: const [], setup: null),
      },
      builder: (context, recent) => SliverToBoxAdapter(
        child: switch (recent) {
          (vocabularies: [], setup: _) || (setup: null, vocabularies: _) => null,
          (:final vocabularies, :final setup?) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Spacing.xxl),
              Padding(
                padding: _pagePadding,
                child: _SectionTitle(title: context.s.homeNewWordsTitle),
              ),
              const SizedBox(height: Spacing.m),
              RecentVocabulariesSection(
                vocabularies: vocabularies,
                language: setup.selected,
                mainLanguage: setup.main,
                onTap: (vocabulary) => _showInfo(context, vocabulary),
                onLongPress: (vocabulary) => _edit(context, vocabulary),
              ),
            ],
          ),
        },
      ),
    );
  }
}

class const _Feed({
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
        _ => (vocabularies: const [], hasMore: false, setup: null),
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
              onLongPress: () => _edit(context, vocabulary),
              onSpeak: () => _speak(context, vocabulary),
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

class const _HomeAppBar() extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: const _LanguageButton(),
      actionsPadding: const EdgeInsets.only(right: Spacing.m),
      actions: const [
        _StreakButton(),
        SizedBox(width: Spacing.xs),
        _AccountButton(),
      ],
    );
  }
}

class const _LanguageButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      HomeBloc,
      HomeState,
      ({LanguageSetup setup, Map<Language, VocabularyOverview> overviews})?
    >(
      selector: (state) => switch (state) {
        HomeLoaded(:final setup, :final overviews) => (setup: setup, overviews: overviews),
        HomeLoading(setup: final setup?, :final overviews) => (setup: setup, overviews: overviews),
        _ => null,
      },
      builder: (context, menu) => switch (menu) {
        final menu? => LanguageMenuButton(setup: menu.setup, overviews: menu.overviews),
        null => const SizedBox.shrink(),
      },
    );
  }
}

class const _StatusArea() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => switch ((previous, current)) {
        (final HomeLoaded before, final HomeLoaded after) =>
          before.overview != after.overview ||
              before.setup != after.setup ||
              before.customSession != after.customSession ||
              before.collections != after.collections ||
              before.overviews != after.overviews ||
              before.importWords != after.importWords ||
              before.isLanguageEmpty != after.isLanguageEmpty,
        _ => true,
      },
      builder: (context, state) => switch (state) {
        final HomeLoaded loaded when loaded.isLanguageEmpty => LanguageImportCard(
          language: loaded.setup.selected,
          source: loaded.importSource,
          sourceCount: switch (loaded.importSource) {
            final source? => loaded.overviews[source]?.totalCount ?? 0,
            null => loaded.allWordsCount,
          },
          words: loaded.importWords,
        ),
        HomeLoaded(:final overview, :final setup, :final customSession, :final collections) =>
          StatusCard(
            overview: overview,
            language: setup.selected,
            newWordLimit: setup.learnedOf(setup.selected)?.newWords,
            customSession: customSession,
            tags: [for (final collection in collections) collection.tag],
            onCustomPracticeEnded: () =>
                context.read<HomeBloc>().add(const HomeCustomPracticeEnded()),
          ),
        HomeLoading() || HomeFailure() => const SizedBox.shrink(),
      },
    );
  }
}

class const _AllWordsHeader({
  required final VoidCallback _onSearchOpened,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Language?>(
      selector: (state) => switch (state) {
        final HomeLoaded loaded when loaded.isLanguageEmpty => loaded.setup.selected,
        _ => null,
      },
      builder: (context, emptyLanguage) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _SectionTitle(title: context.s.homeAllWordsTitle)),
              if (emptyLanguage == null)
                IconButton(
                  onPressed: _onSearchOpened,
                  tooltip: context.s.vocabularySearchTooltip,
                  icon: const Icon(Icons.search_rounded),
                ),
            ],
          ),
          if (emptyLanguage case final language?) ...[
            const SizedBox(height: Spacing.m),
            Text(
              context.s.homeEmptyLanguageFeedHint(language.toShortLabel(context)),
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class const _AccountButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, Account?>(
      builder: (context, account) => switch (account) {
        GoogleAccount(:final picturePath) => IconButton(
          onPressed: context.pushSettings,
          tooltip: context.s.settingsTitle,
          padding: const EdgeInsets.all(Spacing.xxxs),
          icon: AccountStatusAvatar(picturePath: picturePath, radius: _avatarRadius),
        ),
        LocalAccount() || null => IconButton(
          onPressed: context.pushSettings,
          tooltip: context.s.settingsTitle,
          icon: const Icon(Icons.settings_rounded),
        ),
      },
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
      appBar: const _HomeAppBar(),
      floatingActionButton: const RecordFab(),
      body: SafeArea(
        child: Padding(
          padding: _pagePadding,
          child: Column(
            children: [
              const SizedBox(height: Spacing.xxl),
              Text(
                context.s.homeLookAroundTitle,
                style: context.t.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.xl),
                  child: FractionallySizedBox(
                    widthFactor: _backdropWidthFactor,
                    child: Center(child: _SearchingMascot()),
                  ),
                ),
              ),
              const _AddFirstWordHint(),
              const SizedBox(height: _scrollEndSpacing),
            ],
          ),
        ),
      ),
    );
  }
}

class const _AddFirstWordHint() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = context.s.homeAddFirstWordMessage(_plusSymbol);
    final plusStart = message.indexOf(_plusSymbol);
    return Text.rich(
      plusStart < 0
          ? TextSpan(text: message)
          : TextSpan(
              children: [
                TextSpan(text: message.substring(0, plusStart)),
                TextSpan(
                  text: _plusSymbol,
                  style: TextStyle(fontWeight: FontWeight.bold, color: context.c.primary),
                ),
                TextSpan(text: message.substring(plusStart + _plusSymbol.length)),
              ],
            ),
      style: context.t.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}

class const _SearchingMascot() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _searchingMascotAspectRatio,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: context.mascot.backdrop,
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: _mascotHeightFactor,
              child: Mascot(pose: MascotPose.search),
            ),
          ),
        ],
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
  if (bloc.state case HomeLoaded(:final setup, :final collections)) {
    showVocabularyInfoDialog(
      context,
      vocabulary: vocabulary,
      language: setup.selected,
      mainLanguage: setup.main,
      tags: [for (final collection in collections) collection.tag],
      onSpeak: () => bloc.add(HomeVocabularySpeakRequested(vocabulary: vocabulary)),
      onEdit: () => _edit(context, vocabulary),
      onPhotographerOpened: (url) => bloc.add(HomePhotographerLinkOpened(url: url)),
    );
  }
}

void _edit(BuildContext context, Vocabulary vocabulary) {
  context.pushEditVocabularyDetails(vocabularyId: vocabulary.id);
}

void _speak(BuildContext context, Vocabulary vocabulary) {
  context.read<HomeBloc>().add(HomeVocabularySpeakRequested(vocabulary: vocabulary));
}
