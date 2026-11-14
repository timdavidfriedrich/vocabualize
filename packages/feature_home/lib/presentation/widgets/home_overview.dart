import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/extensions/home_context_extensions.dart';
import 'package:feature_home/presentation/extensions/home_loaded_extensions.dart';
import 'package:feature_home/presentation/home_bloc.dart';
import 'package:feature_home/presentation/home_state.dart';
import 'package:feature_home/presentation/widgets/all_words_header.dart';
import 'package:feature_home/presentation/widgets/collections_section.dart';
import 'package:feature_home/presentation/widgets/home_feed.dart';
import 'package:feature_home/presentation/widgets/home_section_title.dart';
import 'package:feature_home/presentation/widgets/home_status_area.dart';
import 'package:feature_home/presentation/widgets/recent_vocabularies_section.dart';
import 'package:feature_home/presentation/widgets/translation_limit_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: Spacing.m);
const _scrollEndSpacing = Spacing.xxxxxl;

class const HomeOverview({
  super.key,
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
                      HomeStatusArea(),
                      TranslationLimitNotice(),
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
                          AllWordsHeader(onSearchOpened: _onSearchOpened),
                          const SizedBox(height: Spacing.xs),
                        ],
                      ),
                    ),
                    const HomeFeed(showsNoResults: false),
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
        HomeLoading() || HomeLoaded() || HomeFailure() => const [],
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
                    child: HomeSectionTitle(title: context.s.homeCollectionsTitle),
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
        HomeLoading() || HomeFailure() => (vocabularies: const [], setup: null),
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
                child: HomeSectionTitle(title: context.s.homeNewWordsTitle),
              ),
              const SizedBox(height: Spacing.m),
              RecentVocabulariesSection(
                vocabularies: vocabularies,
                language: setup.selected,
                mainLanguage: setup.main,
                onTap: (vocabulary) => context.showVocabularyInfo(vocabulary),
                onLongPress: (vocabulary) =>
                    context.pushEditVocabularyDetails(vocabularyId: vocabulary.id),
              ),
            ],
          ),
        },
      ),
    );
  }
}
