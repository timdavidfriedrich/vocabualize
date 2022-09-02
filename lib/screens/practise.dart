import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/logging.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';

class Practise extends StatefulWidget {
  const Practise({Key? key}) : super(key: key);

  @override
  State<Practise> createState() => _PractiseState();
}

class _PractiseState extends State<Practise> {
  bool isSolutionShown = false;

  late Vocabulary currentVoc;

  @override
  void initState() {
    super.initState();
    currentVoc = Provider.of<VocProv>(context).getFirstToPractise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("13/${Provider.of<VocProv>(context).getAllToPractise().length}")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Center(child: Text(currentVoc.getSource())),
            const SizedBox(height: 16),
            !isSolutionShown
                ? Container()
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(child: Text(Provider.of<VocProv>(context).getFirstToPractise().getTarget())),
                    ),
                  ),
            const Spacer(),
            !isSolutionShown
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Provider.of<VocProv>(context, listen: false).getFirstToPractise().answerEasy(),
                        child: const Icon(Icons.sentiment_very_satisfied_rounded),
                      ),
                      ElevatedButton(
                        onPressed: () => Provider.of<VocProv>(context, listen: false).getFirstToPractise().answerMedium(),
                        child: const Icon(Icons.sentiment_satisfied_rounded),
                      ),
                      ElevatedButton(
                        onPressed: () => Provider.of<VocProv>(context, listen: false).getFirstToPractise().answerHard(),
                        child: const Icon(Icons.sentiment_neutral_rounded),
                      ),
                    ],
                  ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => setState(() => isSolutionShown = !isSolutionShown),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Theme.of(context).colorScheme.onSecondary,
              ),
              child: !isSolutionShown ? const Text("Solution") : const Text("Back to question"),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
