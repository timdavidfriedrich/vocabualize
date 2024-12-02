import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/presentation/controllers/details_controller.dart';
import 'package:vocabualize/src/features/details/presentation/states/details_state.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/image_chooser.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/source_to_target.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/tag_wrap.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';

class DetailsScreenArguments {
  final Vocabulary vocabulary;
  DetailsScreenArguments({required this.vocabulary});
}

class DetailsScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/AddDetails";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailsScreenArguments? arguments =
        ModalRoute.of(context)?.settings.arguments as DetailsScreenArguments?;

    final provider = detailsControllerProvider(arguments?.vocabulary);
    final notifier = provider.notifier;
    final asyncState = ref.watch(provider);

    return asyncState.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (error, stackTrace) {
        Log.error("Error in DetailsScreen: $error", exception: stackTrace);
        // TODO: Replace with error widget
        return const Text("Error DetailsScreen");
      },
      data: (DetailsState state) {
        if (state.vocabulary.source.isEmpty) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.largeBorderRadius),
              topRight: Radius.circular(Dimensions.largeBorderRadius),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.extraLargeSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.areImagesEnabled) ...[
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: Dimensions.semiLargeSpacing),
                            SourceToTarget(state: state, notifier: notifier),
                            const SizedBox(height: Dimensions.semiSmallSpacing),
                            ImageChooser(notifier: notifier, state: state),
                            const SizedBox(height: Dimensions.mediumSpacing),
                            TagWrap(state: state, notifier: notifier),
                          ],
                        ),
                      ),
                    ] else ...[
                      const Spacer(),
                      SourceToTarget(
                        state: state,
                        notifier: notifier,
                        isVertical: true,
                      ),
                      const Spacer(),
                      TagWrap(state: state, notifier: notifier),
                    ],
                    const SizedBox(height: Dimensions.mediumSpacing),
                    Row(
                      children: [
                        if (state.vocabulary.id != null) ...[
                          const SizedBox(width: Dimensions.semiSmallSpacing),
                          _DeleteButton(notifier: notifier),
                        ],
                        Expanded(
                          child: _SaveButton(notifier: notifier, state: state),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.smallSpacing),
                    _SettingsButton(notifier: notifier),
                    const SizedBox(height: Dimensions.semiLargeSpacing),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  const _DeleteButton({required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(Dimensions.semiSmallSpacing),
        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
        foregroundColor: Theme.of(context).colorScheme.error,
      ),
      onPressed: () {
        ref.read(notifier).deleteVocabulary(context);
      },
      child: const Icon(Icons.delete_rounded),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  final DetailsState state;
  const _SaveButton({
    required this.notifier,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(notifier).save(context);
      },
      child: Text(
        state.vocabulary.image is FallbackImage
            ? AppLocalizations.of(context)
                    ?.record_addDetails_saveWithoutButton ??
                ""
            : AppLocalizations.of(context)?.record_addDetails_saveButton ?? "",
      ),
    );
  }
}

class _SettingsButton extends ConsumerWidget {
  final Refreshable<DetailsController> notifier;
  const _SettingsButton({required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(notifier).goToSettings(context);
      },
      child: Text(
        AppLocalizations.of(context)
                ?.record_addDetails_neverAskForImageButton ??
            "",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
