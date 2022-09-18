import 'package:flutter/animation.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SettingsSheetController extends SnappingSheetController {
  SnappingPosition retractedPosition = const SnappingPosition.factor(
    positionFactor: 1.0,
    snappingDuration: Duration(milliseconds: 500),
    grabbingContentOffset: GrabbingContentOffset.top,
  );

  SnappingPosition extendedPosition = const SnappingPosition.factor(
    positionFactor: 0.5,
    snappingCurve: ElasticOutCurve(0.9),
    snappingDuration: Duration(milliseconds: 1000),
  );

  show() {
    if (isAttached) snapToPosition(extendedPosition);
  }

  hide() {
    if (isAttached) snapToPosition(retractedPosition);
  }
}
