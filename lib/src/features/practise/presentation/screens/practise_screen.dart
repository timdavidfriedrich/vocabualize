import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extensions.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/practise/presentation/controllers/practise_controller.dart';
import 'package:vocabualize/src/common/domain/entities/answer.dart';
import 'package:vocabualize/src/features/practise/presentation/states/practise_state.dart';

class PractiseScreenArguments {
  final Tag tag;
  PractiseScreenArguments({required this.tag});
}

class PractiseScreen extends ConsumerStatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/Practise";
  const PractiseScreen({super.key});

  @override
  ConsumerState<PractiseScreen> createState() => _PractiseScreenState();
}

class _PractiseScreenState extends ConsumerState<PractiseScreen> {
  Tag? tag;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      PractiseScreenArguments? arguments = ModalRoute.of(context)
          ?.settings
          .arguments as PractiseScreenArguments?;
      setState(() {
        tag = arguments?.tag;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = practiseControllerProvider(tag);
    final notifier = provider.notifier;
    final asyncState = ref.watch(provider);

    return asyncState.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (error, stackTrace) {
        return const _PractiseDoneScreen();
      },
      data: (PractiseState state) {
        if (state.isDone) {
          return const _PractiseDoneScreen();
        }

        final strings = AppLocalizations.of(context);

        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.largeBorderRadius),
              topRight: Radius.circular(Dimensions.largeBorderRadius),
            ),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.extraLargeSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: Dimensions.largeSpacing),
                    _ProgressBar(state: state),
                    const Spacer(),
                    if (state.isMultilingual) ...[
                      _MultilingualLabel(state: state, notifier: notifier),
                    ],
                    const SizedBox(height: Dimensions.semiSmallSpacing),
                    Stack(
                      children: [
                        if (state.areImagesEnabled) ...[
                          _ImageBox(state: state, notifier: notifier),
                        ],
                        if (state.isSolutionShown) ...[
                          _Solution(state: state, notifier: notifier),
                        ],
                      ].map((child) {
                        return AspectRatio(aspectRatio: 4 / 3, child: child);
                      }).toList(),
                    ),
                    const SizedBox(height: Dimensions.largeSpacing),
                    Text(
                      state.currentVocabulary.source,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Opacity(
                      opacity: state.isSolutionShown ? 1 : 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _RateButton(
                              state: state,
                              notifier: notifier,
                              answer: Answer.hard,
                              color: LevelPalette.beginner,
                              text: strings?.pracise_rating_hardButton ?? "",
                            ),
                          ),
                          const SizedBox(width: Dimensions.semiSmallSpacing),
                          Expanded(
                            child: _RateButton(
                              state: state,
                              notifier: notifier,
                              answer: Answer.good,
                              color: LevelPalette.advanced,
                              text: strings?.pracise_rating_goodButton ?? "",
                            ),
                          ),
                          const SizedBox(width: Dimensions.semiSmallSpacing),
                          Expanded(
                            child: _RateButton(
                              state: state,
                              notifier: notifier,
                              answer: Answer.easy,
                              color: LevelPalette.expert,
                              text: strings?.pracise_rating_easyButton ?? "",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.mediumSpacing),
                    if (state.isSolutionShown) ...[
                      _ForgotButton(state: state, notifier: notifier),
                    ] else ...[
                      _ShowSolutionButton(state: state, notifier: notifier),
                    ],
                    const SizedBox(height: Dimensions.extraExtraLargeSpacing),
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

class _PractiseDoneScreen extends StatelessWidget {
  const _PractiseDoneScreen();

  @override
  Widget build(BuildContext context) {
    void close() {
      context.pop();
    }

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.largeBorderRadius),
          topRight: Radius.circular(Dimensions.largeBorderRadius),
        ),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.largeSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Text(
                  // TODO: Replace with arb
                  "Congratulations!",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.mediumSpacing),
                const Text(
                  // TODO: Replace with arb
                  "You finished all\nof your current words!",
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => close(),
                  // TODO: Replace with arb
                  child: const Text("Main menu"),
                ),
                const SizedBox(height: Dimensions.extraExtraLargeSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final PractiseState state;
  const _ProgressBar({required this.state});

  @override
  Widget build(BuildContext context) {
    void close() {
      context.pop();
    }

    final int totalCount = state.initialVocabularyCount;
    final int leftCount = state.vocabulariesLeft.length;
    final int doneCount = totalCount - leftCount;
    final String countText = "$doneCount / $totalCount";

    return Row(
      children: [
        Text(
          countText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(width: Dimensions.semiLargeSpacing),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.smallSpacing),
            child: LinearProgressIndicator(
              value: 1 - (leftCount / totalCount),
              minHeight: Dimensions.semiSmallSpacing,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        const SizedBox(width: Dimensions.mediumSpacing),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => close(),
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}

class _MultilingualLabel extends ConsumerWidget {
  final PractiseState state;
  final Refreshable<PractiseController> notifier;
  const _MultilingualLabel({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(notifier).getMultilingualLabel(state),
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? "",
          style: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}

class _ImageBox extends ConsumerWidget {
  final PractiseState state;
  final Refreshable<PractiseController> notifier;
  const _ImageBox({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimensions.semiLargeSpacing),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: state.currentVocabulary.image.getImageProvider(
            size: ImageSize.medium,
          ),
        ),
      ),
    );
  }
}

class _Solution extends ConsumerWidget {
  final PractiseState state;
  final Refreshable<PractiseController> notifier;
  const _Solution({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.75),
        borderRadius: BorderRadius.circular(Dimensions.semiLargeBorderRadius),
      ),
      child: Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              state.currentVocabulary.target,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: Dimensions.smallSpacing),
          IconButton(
            onPressed: () {
              ref.read(notifier).readOutCurrent();
            },
            icon: const Icon(
              Icons.volume_up_rounded,
              size: Dimensions.largeIconSize,
            ),
          ),
        ],
      )),
    );
  }
}

class _ShowSolutionButton extends ConsumerWidget {
  final PractiseState state;
  final Refreshable<PractiseController> notifier;
  const _ShowSolutionButton({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: ref.read(notifier).showSolution,
      child: Text(
        AppLocalizations.of(context)?.pracise_solutionButton ?? "",
      ),
    );
  }
}

class _ForgotButton extends ConsumerWidget {
  final PractiseState state;
  final Refreshable<PractiseController> notifier;
  const _ForgotButton({
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        ref.read(notifier).answerCurrent(Answer.forgot);
      },
      child: Text(
        AppLocalizations.of(context)?.pracise_rating_didntKnowButton ?? "",
        style: const TextStyle(color: LevelPalette.novice),
      ),
    );
  }
}

class _RateButton extends ConsumerWidget {
  final PractiseState state;
  final Refreshable<PractiseController> notifier;
  final Answer answer;
  final Color color;
  final String text;
  const _RateButton({
    required this.state,
    required this.notifier,
    required this.answer,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.semiSmallSpacing,
        ),
        backgroundColor: color,
      ),
      onPressed: () {
        ref.read(notifier).answerCurrent(answer);
      },
      child: Text(text),
    );
  }
}
