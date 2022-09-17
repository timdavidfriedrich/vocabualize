import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/features/home/screens/home_empty.dart';
import 'package:vocabualize/features/home/widgets/new_word_card.dart';
import 'package:vocabualize/features/record/widgets/record_grab.dart';
import 'package:vocabualize/features/record/widgets/record_sheet.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/home/widgets/status_card.dart';
import 'package:vocabualize/features/home/widgets/vocabulary_list_tile.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';
import 'package:vocabualize/features/settings/widgets/settings_grab.dart';
import 'package:vocabualize/features/settings/widgets/settings_sheet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SettingsSheetController settingsSheetController = SettingsSheetController();

  @override
  void initState() {
    Provider.of<VocabularyProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: SnappingSheet(
            snappingPositions: const [
              SnappingPosition.factor(
                  positionFactor: 0.0,
                  snappingCurve: ElasticOutCurve(0.8),
                  snappingDuration: Duration(milliseconds: 750),
                  grabbingContentOffset: GrabbingContentOffset.top),
              SnappingPosition.factor(
                positionFactor: 0.75,
                snappingCurve: ElasticOutCurve(0.5),
                snappingDuration: Duration(milliseconds: 1000),
              ),
            ],
            grabbing: const RecordGrab(),
            grabbingHeight: 64,
            sheetBelow: SnappingSheetContent(draggable: true, child: const RecordSheet()),
            child: SnappingSheet(
              controller: settingsSheetController,
              snappingPositions: const [
                SnappingPosition.factor(
                  positionFactor: 1.0,
                  snappingDuration: Duration(milliseconds: 500),
                  grabbingContentOffset: GrabbingContentOffset.top,
                )
              ],
              grabbing: const SettingsGrab(),
              grabbingHeight: 64,
              sheetAbove: SnappingSheetContent(draggable: true, child: const SettingsSheet()),
              child: Provider.of<VocabularyProvider>(context).vocabularyList.isEmpty
                  ? const HomeEmpty()
                  : ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 96),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 48),
                        Row(
                          children: [
                            Expanded(child: Text("Vocabualize", style: Theme.of(context).textTheme.headlineLarge)),
                            IconButton(
                              onPressed: () => settingsSheetController.show(),
                              icon: const Icon(Icons.settings_rounded),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const StatusCard(),
                        const SizedBox(height: 32),
                        Text("New words", style: Theme.of(context).textTheme.headlineMedium),
                        OverflowBox(
                          minWidth: 0.0,
                          minHeight: 0.0,
                          maxWidth: double.infinity,
                          maxHeight: 64,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  Provider.of<VocabularyProvider>(context).lastest.length,
                                  (index) => NewWordCard(
                                    vocabulary: Provider.of<VocabularyProvider>(context, listen: false).vocabularyList.elementAt(index),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(height: 12),
                        const Text("dies das"),
                        const SizedBox(height: 32),
                        Text("All words", style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            Provider.of<VocabularyProvider>(context).vocabularyList.length,
                            (index) =>
                                VocabularyListTile(vocabulary: Provider.of<VocabularyProvider>(context).vocabularyList.elementAt(index)),
                          ).reversed.toList(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
