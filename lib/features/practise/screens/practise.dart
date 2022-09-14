import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/features/core/services/log.dart';
import 'package:vocabualize/features/core/providers/voc_provider.dart';

class Practise extends StatefulWidget {
  const Practise({Key? key}) : super(key: key);

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
    if (Provider.of<VocProv>(context, listen: false).allToPractise.isNotEmpty) {
      setState(() => currentVoc = Provider.of<VocProv>(context, listen: false).firstToPractise);
    } else {
      setState(() => isDone = true);
    }
  }

  @override
  void initState() {
    super.initState();
    initialVocCount = Provider.of<VocProv>(context, listen: false).allToPractise.length;
    refreshVoc();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<VocProv>(context).allToPractise.isEmpty
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
                      Text("${Provider.of<VocProv>(context).allToPractise.length} left",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: Provider.of<VocProv>(context).allToPractise.isEmpty
                              ? 1
                              : 1 - (Provider.of<VocProv>(context).allToPractise.length / initialVocCount),
                          minHeight: 12,
                          color: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const Spacer(),
                      Center(child: Text(currentVoc.source)),
                      const SizedBox(height: 16),
                      !isSolutionShown
                          ? Container()
                          : Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(child: Text(Provider.of<VocProv>(context).firstToPractise.target)),
                              ),
                            ),
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
                                      primary: LevelPalette.beginner,
                                    ),
                                    onPressed: () async {
                                      Log.error("BEFORE: $currentVoc");
                                      await Provider.of<VocProv>(context, listen: false).firstToPractise.answer(Answer.hard);
                                      Log.error("AFTER: $currentVoc");
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
                                      primary: LevelPalette.advanced,
                                    ),
                                    onPressed: () async {
                                      Log.warning("BEFORE: $currentVoc");
                                      await Provider.of<VocProv>(context, listen: false).firstToPractise.answer(Answer.good);
                                      Log.warning("AFTER: $currentVoc");
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
                                      primary: LevelPalette.expert,
                                    ),
                                    onPressed: () async {
                                      Log.hint("BEFORE: $currentVoc");
                                      await Provider.of<VocProv>(context, listen: false).firstToPractise.answer(Answer.easy);
                                      Log.hint("AFTER: $currentVoc");
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
                                await Provider.of<VocProv>(context, listen: false).firstToPractise.answer(Answer.forgot);
                                refreshVoc();
                              },
                              child: const Text("I forgot the word"),
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

class PractiseDone extends StatelessWidget {
  const PractiseDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Congratulations!\n",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const TextSpan(text: "You finished all of your current words!"),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  // change pop to pushReplace (fix collection grow)
                  onPressed: () => Navigator.pop(
                    context,
                    //Teleport(child: const Home(), type: "fade"),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.surface, onPrimary: Theme.of(context).colorScheme.onSurface),
                  child: const Text("Main menu"),
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
