import 'package:vocabualize/constants/common_imports.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/features/record/services/record_sheet_controller.dart';
import 'package:vocabualize/features/record/widgets/record_grab.dart';
import 'package:vocabualize/features/record/widgets/record_sheet.dart';
import 'package:vocabualize/features/settings/services/settings_sheet_controller.dart';
import 'package:vocabualize/features/settings/widgets/settings_grab.dart';
import 'package:vocabualize/features/settings/widgets/settings_sheet.dart';

class DoubleSheet extends StatefulWidget {
  final Widget child;
  final SettingsSheetController settingsSheetController;
  final RecordSheetController recordSheetController;

  const DoubleSheet({super.key, required this.child, required this.settingsSheetController, required this.recordSheetController});

  @override
  State<DoubleSheet> createState() => _DoubleSheetState();
}

class _DoubleSheetState extends State<DoubleSheet> {
  bool recordIsExtended = false;
  bool settingsIsExtended = false;

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      controller: widget.settingsSheetController,
      initialSnappingPosition: widget.settingsSheetController.retractedPosition,
      snappingPositions: [widget.settingsSheetController.retractedPosition, widget.settingsSheetController.extendedPosition],
      grabbing: const SettingsGrab(),
      grabbingHeight: 64,
      // onSheetMoved: (positionData) => setState(() => settingsIsExtended = false),
      // onSnapCompleted: (positionData, snappingPosition) {
      //   if (snappingPosition == widget.settingsSheetController.extendedPosition) setState(() => settingsIsExtended = true);
      // },
      // sheetBelow: settingsIsExtended
      //     ? SnappingSheetContent(
      //         draggable: false,
      //         child: GestureDetector(
      //           onTap: () => widget.settingsSheetController.hide(),
      //           child: Container(color: Colors.transparent),
      //         ),
      //       )
      //     : null,
      sheetAbove: SnappingSheetContent(draggable: true, child: const SettingsSheet()),
      child: SnappingSheet(
        controller: widget.recordSheetController,
        initialSnappingPosition: widget.recordSheetController.retractedPosition,
        snappingPositions: [widget.recordSheetController.retractedPosition, widget.recordSheetController.extendedPosition],
        grabbing: const RecordGrab(),
        grabbingHeight: 64,
        // onSheetMoved: (positionData) => setState(() => recordIsExtended = false),
        // onSnapCompleted: (positionData, snappingPosition) {
        //   if (snappingPosition == widget.recordSheetController.extendedPosition) setState(() => recordIsExtended = true);
        // },
        // sheetAbove: recordIsExtended
        //     ? SnappingSheetContent(
        //         draggable: false,
        //         child: GestureDetector(
        //           onTap: () => widget.recordSheetController.hide(),
        //           child: Container(color: Colors.transparent),
        //         ),
        //       )
        //     : null,
        sheetBelow: SnappingSheetContent(draggable: true, child: const RecordSheet()),
        child: widget.child,
      ),
    );
  }
}
