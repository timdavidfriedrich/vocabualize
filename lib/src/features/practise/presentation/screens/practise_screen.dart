import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/extensions/object_extensions.dart';
import 'package:vocabualize/src/common/domain/use_cases/language/get_language_by_id_use_case.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/practise/presentation/controllers/practise_controller.dart';
import 'package:vocabualize/src/features/practise/presentation/screens/practise_done_screen.dart';
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

  void _close() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      PractiseScreenArguments? arguments = ModalRoute.of(context)?.settings.arguments as PractiseScreenArguments?;
      setState(() {
        tag = arguments?.tag;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> getMultilingualLabel(PractiseState state) async {
      final currentVocabulary = state.currentVocabulary;
      final getLanguageById = ref.read(getLanguageByIdUseCaseProvider);
      final currentSourceLanguage = await getLanguageById(currentVocabulary.sourceLanguageId);
      final currentTargetLanguage = await getLanguageById(currentVocabulary.targetLanguageId);
      return "${currentSourceLanguage?.name}  ►  ${currentTargetLanguage?.name}";
    }

    return ref.watch(practiseControllerProvider(tag)).when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (error, stackTrace) {
        return const PractiseDoneScreen();
      },
      data: (PractiseState state) {
        if (state.isDone) {
          return const PractiseDoneScreen();
        }
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Text(
                          "${state.initialVocabularyCount - state.vocabulariesLeftToPractise.length} / ${state.initialVocabularyCount}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: state.isDone ? 1 : 1 - (state.vocabulariesLeftToPractise.length / state.initialVocabularyCount),
                              minHeight: 12,
                              color: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(padding: EdgeInsets.zero, onPressed: () => _close(), icon: const Icon(Icons.close_rounded, weight: 4)),
                      ],
                    ),
                    const Spacer(),
                    if (state.isMultilingual) ...[
                      FutureBuilder(
                        future: getMultilingualLabel(state),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }
                          return Text(
                            snapshot.data ?? "",
                            style: TextStyle(color: Theme.of(context).hintColor),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (state.areImagesEnabled || state.isSolutionShown) ...[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                state.currentVocabulary.image.url,
                              ),
                            ).takeUnless((_) => state.areImagesEnabled),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(24),
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
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    ref.read(practiseControllerProvider(tag).notifier).readOut(state.currentVocabulary);
                                  },
                                  icon: const Icon(Icons.volume_up_rounded, size: 32),
                                ),
                              ],
                            )),
                          ).takeUnless((_) => state.isSolutionShown),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    Center(child: Text(state.currentVocabulary.source, style: Theme.of(context).textTheme.bodyMedium)),
                    const Spacer(),
                    if (state.isSolutionShown)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                backgroundColor: LevelPalette.beginner,
                              ),
                              onPressed: () {
                                ref.read(practiseControllerProvider(tag).notifier).answer(
                                      vocabulary: state.currentVocabulary,
                                      answer: Answer.hard,
                                    );
                              },
                              child: Text(AppLocalizations.of(context)?.pracise_rating_hardButton ?? ""),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                backgroundColor: LevelPalette.advanced,
                              ),
                              onPressed: () {
                                ref.read(practiseControllerProvider(tag).notifier).answer(
                                      vocabulary: state.currentVocabulary,
                                      answer: Answer.good,
                                    );
                              },
                              child: Text(AppLocalizations.of(context)?.pracise_rating_goodButton ?? ""),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                backgroundColor: LevelPalette.expert,
                              ),
                              onPressed: () {
                                ref.read(practiseControllerProvider(tag).notifier).answer(
                                      vocabulary: state.currentVocabulary,
                                      answer: Answer.easy,
                                    );
                              },
                              child: Text(AppLocalizations.of(context)?.pracise_rating_easyButton ?? ""),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    if (state.isSolutionShown) ...[
                      OutlinedButton(
                        onPressed: () {
                          ref.read(practiseControllerProvider(tag).notifier).answer(
                                vocabulary: state.currentVocabulary,
                                answer: Answer.forgot,
                              );
                        },
                        child: Text(
                          AppLocalizations.of(context)?.pracise_rating_didntKnowButton ?? "",
                          style: const TextStyle(color: LevelPalette.novice),
                        ),
                      )
                    ] else ...[
                      ElevatedButton(
                        onPressed: ref.read(practiseControllerProvider(tag).notifier).showSolution,
                        child: Text(AppLocalizations.of(context)?.pracise_solutionButton ?? ""),
                      )
                    ],
                    const SizedBox(height: 64),
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
