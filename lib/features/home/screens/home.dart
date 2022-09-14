import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/features/home/widgets/record_sheet.dart';
import 'package:vocabualize/features/settings/screens/settings.dart';
import 'package:vocabualize/features/core/providers/voc_provider.dart';
import 'package:vocabualize/features/core/services/teleport.dart';
import 'package:vocabualize/features/home/widgets/status_card.dart';
import 'package:vocabualize/features/home/widgets/voc_list_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<VocProv>(context, listen: false).initVocabularyList();
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
                  snappingCurve: Curves.elasticOut,
                  snappingDuration: Duration(milliseconds: 1000),
                  grabbingContentOffset: GrabbingContentOffset.top),
              SnappingPosition.factor(
                positionFactor: 0.75,
                snappingCurve: Curves.elasticOut,
                snappingDuration: Duration(milliseconds: 1000),
              ),
            ],
            grabbing: const RecordGrab(),
            grabbingHeight: 64,
            sheetBelow: SnappingSheetContent(draggable: true, child: const RecordSheet()),
            child: Provider.of<VocProv>(context).vocabularyList.isEmpty
                ? const HomeEmpty()
                : ListView(
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
                          Provider.of<VocProv>(context).vocabularyList.length,
                          (index) => VocListTile(vocabulary: Provider.of<VocProv>(context).vocabularyList.elementAt(index)),
                        ).reversed.toList(),
                      ),
                    ],
                  ),
          ),
        ),
      ),
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
