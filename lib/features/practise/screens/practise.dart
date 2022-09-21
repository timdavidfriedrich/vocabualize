import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/practise/screens/practise_done.dart';
import 'package:vocabualize/features/practise/services/answer.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Practise extends StatefulWidget {
  const Practise({Key? key}) : super(key: key);

  static const routeName = "/practise";

  @override
  State<Practise> createState() => _PractiseState();
}

class _PractiseState extends State<Practise> {
  int initialVocCount = 0;
  bool isSolutionShown = false;
  bool isDone = false;
  late Vocabulary currentVoc;

  void refreshVoc() {
    setState(() => isSolutionShown = false);
    if (Provider.of<VocabularyProvider>(context, listen: false).allToPractise.isNotEmpty) {
      setState(() => currentVoc = Provider.of<VocabularyProvider>(context, listen: false).firstToPractise);
    } else {
      setState(() => isDone = true);
    }
  }

  @override
  void initState() {
    super.initState();
    initialVocCount = Provider.of<VocabularyProvider>(context, listen: false).allToPractise.length;
    refreshVoc();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<VocabularyProvider>(context).allToPractise.isEmpty
        ? const PractiseDone()
        : SafeArea(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),
                      Text("${Provider.of<VocabularyProvider>(context).allToPractise.length} left",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: Provider.of<VocabularyProvider>(context).allToPractise.isEmpty
                              ? 1
                              : 1 - (Provider.of<VocabularyProvider>(context).allToPractise.length / initialVocCount),
                          minHeight: 12,
                          color: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const Spacer(),
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
                                          image: CachedNetworkImageProvider(
                                            Provider.of<VocabularyProvider>(context, listen: false)
                                                .firstToPractise
                                                .imageModel
                                                .src["medium"],
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
                                          child: Text(Provider.of<VocabularyProvider>(context).firstToPractise.target,
                                              style: Theme.of(context).textTheme.headlineMedium),
                                        ),
                                      ),
                              ),
                            ),
                      const SizedBox(height: 32),
                      Center(child: Text(currentVoc.source, style: Theme.of(context).textTheme.bodyMedium)),
                      const Spacer(),
                      !isSolutionShown
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                      backgroundColor: LevelPalette.beginner,
                                    ),
                                    onPressed: () async {
                                      await Provider.of<VocabularyProvider>(context, listen: false).firstToPractise.answer(Answer.hard);
                                      refreshVoc();
                                    },
                                    child: const Text("Hard"),
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
                                      await Provider.of<VocabularyProvider>(context, listen: false).firstToPractise.answer(Answer.good);
                                      refreshVoc();
                                    },
                                    child: const Text("Good"),
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
                                      await Provider.of<VocabularyProvider>(context, listen: false).firstToPractise.answer(Answer.easy);
                                      refreshVoc();
                                    },
                                    child: const Text("Easy"),
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 16),
                      !isSolutionShown
                          ? ElevatedButton(
                              onPressed: () => setState(() => isSolutionShown = true),
                              child: const Text("Solution"),
                            )
                          : OutlinedButton(
                              onPressed: () async {
                                Log.hint("BEFORE: $currentVoc");
                                await Provider.of<VocabularyProvider>(context, listen: false).firstToPractise.answer(Answer.forgot);
                                Log.hint("BEFORE: $currentVoc");
                                refreshVoc();
                              },
                              child: const Text("I forgot the word", style: TextStyle(color: LevelPalette.novice)),
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
