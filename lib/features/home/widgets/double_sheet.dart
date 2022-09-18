import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/record/widgets/record_grab.dart';
import 'package:vocabualize/features/record/widgets/record_sheet.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';
import 'package:vocabualize/features/settings/widgets/settings_grab.dart';
import 'package:vocabualize/features/settings/widgets/settings_sheet.dart';

class DoubleSheet extends StatelessWidget {
  final Widget child;
  final SettingsSheetController settingsSheetController;
  final RecordSheetController recordSheetController;
  const DoubleSheet({super.key, required this.child, required this.settingsSheetController, required this.recordSheetController});

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      initialSnappingPosition: recordSheetController.retractedPosistion,
      snappingPositions: [recordSheetController.retractedPosistion, recordSheetController.extendedPosistion],
      grabbing: const RecordGrab(),
      grabbingHeight: 64,
      sheetBelow: SnappingSheetContent(draggable: true, child: const RecordSheet()),
      child: SnappingSheet(
        controller: settingsSheetController,
        initialSnappingPosition: settingsSheetController.retractedPosistion,
        snappingPositions: [settingsSheetController.retractedPosistion, settingsSheetController.extendedPosistion],
        grabbing: const SettingsGrab(),
        grabbingHeight: 64,
        sheetAbove: SnappingSheetContent(draggable: true, child: const SettingsSheet()),
        child: child,
      ),
    );
  }
}
