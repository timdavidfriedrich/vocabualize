import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/screens/practise.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/teleport.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.displayMedium,
                children: [
                  TextSpan(text: "Wow, you already added ${Provider.of<VocProv>(context).createdToday.length} words today."),
                  const TextSpan(text: "\n\n"),
                  const TextSpan(text: "Let's practise!", style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.beginner),
                      Text("${Provider.of<VocProv>(context).vocabularyList.where((voc) => voc.level > 0 && voc.level < 1).length}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.advanced),
                      Text("${Provider.of<VocProv>(context).vocabularyList.where((voc) => voc.level >= 1 && voc.level < 2).length}"),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.expert),
                      Text("${Provider.of<VocProv>(context).vocabularyList.where((voc) => voc.level >= 2).length}"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () => Navigator.push(context, Teleport(child: const Practise())).then((value) => setState(() => {})),
                  child: const Text("Practise")),
            ],
          )
        ],
      ),
    );
  }
}
