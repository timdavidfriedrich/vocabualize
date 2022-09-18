import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class RecordSheetController extends SnappingSheetController {
  SnappingPosition retractedPosistion = const SnappingPosition.factor(
      positionFactor: 0.0,
      snappingCurve: ElasticOutCurve(0.8),
      snappingDuration: Duration(milliseconds: 750),
      grabbingContentOffset: GrabbingContentOffset.top);
  SnappingPosition extendedPosistion = const SnappingPosition.factor(
    positionFactor: 0.75,
    snappingCurve: ElasticOutCurve(0.5),
    snappingDuration: Duration(milliseconds: 1000),
  );
}
