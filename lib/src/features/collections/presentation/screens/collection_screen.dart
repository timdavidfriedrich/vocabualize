import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/features/collections/presentation/controllers/collection_controller.dart';
import 'package:vocabualize/src/features/collections/presentation/states/collection_state.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/common/presentation/widgets/status_card_indicator.dart';
import 'package:vocabualize/src/common/presentation/widgets/vocabulary_list_tile.dart';

class CollectionScreenArguments {
  final Tag tag;
  CollectionScreenArguments({required this.tag});
}

class CollectionScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/Collection";

  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CollectionScreenArguments? arguments = ModalRoute.of(context)
        ?.settings
        .arguments as CollectionScreenArguments?;

    final provider = collectionControllerProvider(arguments?.tag);
    final notifier = provider.notifier;
    final asyncState = ref.watch(provider);

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.largeBorderRadius),
          topRight: Radius.circular(Dimensions.largeBorderRadius),
        ),
        child: asyncState.when(
          loading: () {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
          error: (e, stackTrace) {
            Log.error("Error CollectionScreen: $e", exception: stackTrace);
            // TODO: Replace with error widget and arb
            return const Center(child: Text("Error CollectionScreen"));
          },
          data: (CollectionState state) {
            return Scaffold(
              appBar: AppBar(
                title: _CollectionTitle(state: state),
                actions: [_EditButton(notifier: notifier)],
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.largeSpacing,
                ),
                children: [
                  const SizedBox(height: Dimensions.mediumSpacing),
                  StatusCardIndicator(
                    tag: state.tag,
                    parent: _PractiseButton(state: state, notifier: notifier),
                  ),
                  const SizedBox(height: Dimensions.mediumSpacing),
                  for (final vocabulary in state.tagVocabularies.reversed)
                    VocabularyListTile(
                      areImagesEnabled: state.areImagesEnabled,
                      vocabulary: vocabulary,
                    ),
                  const SizedBox(height: Dimensions.scrollEndSpacing),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CollectionTitle extends StatelessWidget {
  final CollectionState state;
  const _CollectionTitle({required this.state});

  @override
  Widget build(BuildContext context) {
    return Text(
      state.tag.name,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _EditButton extends ConsumerWidget {
  final Refreshable<CollectionController> notifier;
  const _EditButton({required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.edit_rounded),
      onPressed: () {
        ref.read(notifier).editTag();
      },
    );
  }
}

class _PractiseButton extends ConsumerWidget {
  final CollectionState state;
  final Refreshable<CollectionController> notifier;
  const _PractiseButton({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ref.read(notifier).startPractise(context);
        },
        child: Text(
          AppLocalizations.of(context)?.home_statusCard_practiseButton ?? "",
        ),
      ),
    );
  }
}
