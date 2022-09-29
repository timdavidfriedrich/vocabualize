import 'dart:async';

import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/features/home/services/card_generator.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/practise/screens/practise.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  late Timer timer;

  _startReloadTimer() async {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {});
      Log.hint("Reloaded status card.");
    });
    Log.hint("Started status card timer.");
  }

  _cancelReloadTimer() {
    timer.cancel();
    Log.hint("Canceled status card timer.");
  }

  @override
  void initState() {
    super.initState();
    _startReloadTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelReloadTimer();
  }

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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pushNamed(context, Practise.routeName), child: const Text("Practise")),
                  !CardGenerator.isIndicatorVisible
                      ? Container()
                      : Positioned(
                          top: -4,
                          right: -4,
                          // child: Icon(
                          //   Icons.circle_rounded,
                          //   size: 16,
                          //   color: CardGenerator.isIndicatorVisible ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
                          // ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "${Provider.of<VocabularyProvider>(context).allToPractise.length}",
                              style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 10),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
