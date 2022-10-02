import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/features/core/services/text_to_speech.dart';
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

  _speak() {
    TTS.speak(currentVoc.target);
  }

  void _refreshVoc() {
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
    _refreshVoc();
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
                                      : DecorationImage(fit: BoxFit.cover, image: currentVoc.imageProvider),
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
                                            IconButton(onPressed: () => _speak(), icon: const Icon(Icons.volume_up_rounded, size: 32)),
                                          ],
                                        )),
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
                                      await currentVoc.answer(Answer.hard);
                                      _refreshVoc();
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
                                      await currentVoc.answer(Answer.good);
                                      _refreshVoc();
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
                                      await currentVoc.answer(Answer.easy);
                                      _refreshVoc();
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
                                await currentVoc.answer(Answer.forgot);
                                _refreshVoc();
                              },
                              child: const Text("I didn't know", style: TextStyle(color: LevelPalette.novice)),
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
