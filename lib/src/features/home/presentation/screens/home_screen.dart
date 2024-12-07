import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/asset_path.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/features/home/presentation/controllers/home_controller.dart';
import 'package:vocabualize/src/features/home/presentation/states/home_state.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/collections_section.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/new_vocabularies_section.dart';
import 'package:vocabualize/src/features/home/presentation/widgets/status_card.dart';
import 'package:vocabualize/src/common/presentation/widgets/vocabulary_list_tile.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = "/Home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = homeControllerProvider;
    final notifier = provider.notifier;
    final asyncState = ref.watch(provider);

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.largeSpacing),
          topRight: Radius.circular(Dimensions.largeSpacing),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              ref.read(notifier).goToRecordScreen(context);
            },
            child: const Icon(Icons.add_rounded),
          ),
          body: asyncState.when(
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            error: (error, stackTrace) {
              // TODO: Replace with error widget
              return _HomeEmptyScreen(notifier: notifier);
            },
            data: (HomeState state) {
              if (state.vocabularies.isEmpty) {
                return _HomeEmptyScreen(notifier: notifier);
              }
              return ListView(
                physics: const BouncingScrollPhysics(),
                restorationId: "homeScreen",
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.largeSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: Dimensions.largeSpacing,
                        ),
                        Row(
                          children: [
                            const Expanded(child: _AppTitle()),
                            const SizedBox(width: Dimensions.mediumSpacing),
                            _BugReportButton(notifier: notifier),
                            _SettingsButton(notifier: notifier),
                          ],
                        ),
                        const SizedBox(height: Dimensions.semiLargeSpacing),
                        StatusCard(state: state),
                      ],
                    ),
                  ),
                  if (state.newVocabularies.isNotEmpty) ...[
                    const SizedBox(height: Dimensions.largeSpacing),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.largeSpacing,
                      ),
                      child: _SectionTitle(
                          AppLocalizations.of(context)?.home_newWords ?? ""),
                    ),
                    const SizedBox(height: Dimensions.semiSmallSpacing),
                    NewVocabulariesSection(state: state, notifier: notifier),
                  ],
                  if (state.tags.isNotEmpty) ...[
                    const SizedBox(height: Dimensions.largeSpacing),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.largeSpacing,
                      ),
                      // TODO: Replace with arb
                      child: _SectionTitle("Collections"),
                    ),
                    const SizedBox(height: Dimensions.semiSmallSpacing),
                    CollectionsSection(state: state, notifier: notifier),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.largeSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.largeSpacing),
                        _SectionTitle(
                            AppLocalizations.of(context)?.home_allWords ?? ""),
                        const SizedBox(height: Dimensions.semiSmallSpacing),
                        _VocabularyFeed(state: state),
                        const SizedBox(
                            height: Dimensions.extraExtraLargeSpacing),
                        const SizedBox(
                            height: Dimensions.extraExtraLargeSpacing),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeEmptyScreen extends StatelessWidget {
  final Refreshable<HomeController> notifier;
  const _HomeEmptyScreen({required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.largeSpacing,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: Dimensions.largeSpacing),
          Row(
            children: [
              const Expanded(child: _AppTitle()),
              const SizedBox(width: Dimensions.mediumSpacing),
              _BugReportButton(notifier: notifier),
              _SettingsButton(notifier: notifier),
            ],
          ),
          // image from assets
          const Spacer(),
          Image.asset(
            AssetPath.mascotSave,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: Dimensions.mediumSpacing),
          const Text(
            // TODO: Replace with arb
            "Swipe up to add\nyour first word.",
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _AppTitle extends StatelessWidget {
  const _AppTitle();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.centerLeft,
      fit: BoxFit.scaleDown,
      child: Text(
        CommonConstants.appName,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _BugReportButton extends ConsumerWidget {
  final Refreshable<HomeController> notifier;
  const _BugReportButton({required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(notifier).openReportPage(context);
      },
      icon: const Icon(Icons.bug_report_rounded),
    );
  }
}

class _SettingsButton extends ConsumerWidget {
  final Refreshable<HomeController> notifier;
  const _SettingsButton({required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(notifier).showSettings(context);
      },
      icon: const Icon(Icons.settings_rounded),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _VocabularyFeed extends StatelessWidget {
  final HomeState state;
  const _VocabularyFeed({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        state.vocabularies.length,
        (index) => VocabularyListTile(
          areImagesEnabled: state.areImagesEnabled,
          vocabulary: state.vocabularies.elementAt(index),
        ),
      ).reversed.toList(),
    );
  }
}
