import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleport/teleport.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/features/home/services/card_generator.dart';
import 'package:vocabualize/features/practise/screens/practise.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';

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
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(CardGenerator.info, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.beginner),
                      Text(
                        "${Provider.of<VocabularyProvider>(context).vocabularyList.where((voc) => voc.level.color == LevelPalette.beginner).length}",
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.advanced),
                      Text(
                        "${Provider.of<VocabularyProvider>(context).vocabularyList.where((voc) => voc.level.color == LevelPalette.advanced).length}",
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      const Icon(Icons.circle, color: LevelPalette.expert),
                      Text(
                        "${Provider.of<VocabularyProvider>(context).vocabularyList.where((voc) => voc.level.color == LevelPalette.expert).length}",
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(onPressed: () => Navigator.push(context, Teleport(child: const Practise())), child: const Text("Practise")),
            ],
          )
        ],
      ),
    );
  }
}
