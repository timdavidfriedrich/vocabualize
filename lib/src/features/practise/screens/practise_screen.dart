import 'package:flutter/scheduler.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/answer_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/is_collection_multilingual_use_case.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/practise/screens/practise_done_screen.dart';
import 'package:vocabualize/src/common/domain/entities/answer.dart';
import 'package:vocabualize/src/features/practise/utils/practise_arguments.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class PractiseScreen extends StatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/Practise";
  const PractiseScreen({super.key});

  @override
  State<PractiseScreen> createState() => _PractiseScreenState();
}

class _PractiseScreenState extends State<PractiseScreen> {
  final answerVocabulary = sl.get<AnswerVocabularyUseCase>();
  final isCollectionMultilingual = sl.get<IsCollectionMultilingualUseCase>();
  final speak = sl.get<ReadOutUseCase>();

  List<Vocabulary> vocabulariesToPractise = [];
  int initialVocCount = 0;
  bool isSolutionShown = false;
  bool isDone = false;
  Vocabulary currentVoc = Vocabulary(source: "", target: "");

  bool isMultilingual = false;

  void _refreshVoc() {
    if (!mounted) return;
    setState(() => isSolutionShown = false);
    if (vocabulariesToPractise.isEmpty) {
      setState(() => isDone = true);
    } else {
      setState(() {
        if (currentVoc.source.isEmpty && vocabulariesToPractise.isEmpty) return;
        vocabulariesToPractise.remove(currentVoc);
        if (vocabulariesToPractise.isEmpty) return;
        currentVoc = vocabulariesToPractise.first;
      });
    }
  }

  void _close() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      PractiseScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as PractiseScreenArguments;
      setState(() {
        vocabulariesToPractise = arguments.vocabulariesToPractise;
        initialVocCount = vocabulariesToPractise.length;
      });
      if (vocabulariesToPractise.isEmpty) return;
      _refreshVoc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return vocabulariesToPractise.isEmpty
        ? const PractiseDoneScreen()
        : SafeArea(
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
                          Text("${initialVocCount - vocabulariesToPractise.length} / $initialVocCount",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 24),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: vocabulariesToPractise.isEmpty ? 1 : 1 - (vocabulariesToPractise.length / initialVocCount),
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
                      FutureBuilder(
                        future: isCollectionMultilingual(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }
                          isMultilingual = snapshot.data as bool;
                          if (!isMultilingual) {
                            return const SizedBox();
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${currentVoc.sourceLanguage.name}  ►  ${currentVoc.targetLanguage.name}",
                                style: TextStyle(color: Theme.of(context).hintColor),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      ),
                      Provider.of<SettingsProvider>(context).areImagesDisabled && !isSolutionShown
                          ? Container()
                          : Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(24),
                                  image: Provider.of<SettingsProvider>(context).areImagesDisabled
                                      ? null
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            currentVoc.image.url,
                                          ),
                                        ),
                                ),
                                child: !isSolutionShown
                                    ? null
                                    : Container(
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
                                                currentVoc.target,
                                                style: Theme.of(context).textTheme.headlineMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            IconButton(
                                              onPressed: () => speak(currentVoc),
                                              icon: const Icon(Icons.volume_up_rounded, size: 32),
                                            ),
                                          ],
                                        )),
                                      ),
                              ),
                            ),
                      const SizedBox(height: 32),
                      Center(child: Text(currentVoc.source, style: Theme.of(context).textTheme.bodyMedium)),
                      const Spacer(),
                      if (isSolutionShown)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  backgroundColor: LevelPalette.beginner,
                                ),
                                onPressed: () async {
                                  await answerVocabulary(
                                    vocabulary: currentVoc,
                                    answer: Answer.hard,
                                  );
                                  _refreshVoc();
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
                                onPressed: () async {
                                  await answerVocabulary(
                                    vocabulary: currentVoc,
                                    answer: Answer.good,
                                  );
                                  _refreshVoc();
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
                                onPressed: () async {
                                  await answerVocabulary(
                                    vocabulary: currentVoc,
                                    answer: Answer.easy,
                                  );
                                  _refreshVoc();
                                },
                                child: Text(AppLocalizations.of(context)?.pracise_rating_easyButton ?? ""),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 16),
                      !isSolutionShown
                          ? ElevatedButton(
                              onPressed: () => setState(() => isSolutionShown = true),
                              child: Text(AppLocalizations.of(context)?.pracise_solutionButton ?? ""),
                            )
                          : OutlinedButton(
                              onPressed: () async {
                                await answerVocabulary(
                                  vocabulary: currentVoc,
                                  answer: Answer.forgot,
                                );
                                _refreshVoc();
                              },
                              child: Text(
                                AppLocalizations.of(context)?.pracise_rating_didntKnowButton ?? "",
                                style: const TextStyle(color: LevelPalette.novice),
                              ),
                            ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
