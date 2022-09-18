import 'package:flutter/animation.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SettingsSheetController extends SnappingSheetController {
  SnappingPosition retractedPosistion = const SnappingPosition.factor(
    positionFactor: 1.0,
    snappingDuration: Duration(milliseconds: 500),
    grabbingContentOffset: GrabbingContentOffset.top,
  );

  SnappingPosition extendedPosistion = const SnappingPosition.factor(
    positionFactor: 0.25,
    snappingCurve: ElasticOutCurve(0.9),
    snappingDuration: Duration(milliseconds: 1000),
  );

  show() {
    snapToPosition(extendedPosistion);
  }
}
