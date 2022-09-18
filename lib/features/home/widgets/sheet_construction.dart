import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/features/record/widgets/record_grab.dart';
import 'package:vocabualize/features/record/widgets/record_sheet.dart';
import 'package:vocabualize/features/settings/widgets/settings_grab.dart';
import 'package:vocabualize/features/settings/widgets/settings_sheet.dart';

class SheetConstruction extends StatelessWidget {
  final Widget child;
  final SnappingSheetController settingsSheetController;
  const SheetConstruction({super.key, required this.child, required this.settingsSheetController});

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
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
        child: child,
      ),
    );
  }
}
