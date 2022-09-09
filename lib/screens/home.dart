import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/screens/settings.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/teleport.dart';
import 'package:vocabualize/widgets/status_card.dart';
import 'package:vocabualize/widgets/voc_list_tile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 96),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(child: Text("Vocabualize", style: Theme.of(context).textTheme.headlineLarge)),
            IconButton(
              onPressed: () => Navigator.push(context, Teleport(child: const Settings(), type: "slide_bottom")),
              icon: const Icon(Icons.settings_rounded),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const StatusCard(),
        const SizedBox(height: 32),
        Text("New words", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        const Text("dies das"),
        const SizedBox(height: 32),
        Text("All words", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            Provider.of<VocProv>(context).getVocabularyList().length,
            (index) => VocListTile(vocabulary: Provider.of<VocProv>(context).getVocabularyList().elementAt(index)),
          ),
        ),
      ],
    );
  }
}

class HomeEmpty extends StatelessWidget {
  const HomeEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Swipe up to add your first word.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
