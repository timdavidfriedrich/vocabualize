import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class RecordSheetController extends SnappingSheetController {
  SnappingPosition retractedPosition = const SnappingPosition.factor(
    positionFactor: 0.0,
    snappingCurve: ElasticOutCurve(0.8),
    snappingDuration: Duration(milliseconds: 750),
    grabbingContentOffset: GrabbingContentOffset.top,
  );
  SnappingPosition extendedPosition = const SnappingPosition.factor(
    positionFactor: 0.75,
    snappingCurve: ElasticOutCurve(0.5),
    snappingDuration: Duration(milliseconds: 1000),
  );

  show() {
    if (isAttached) snapToPosition(extendedPosition);
  }

  hide() {
    if (isAttached) snapToPosition(retractedPosition);
  }
}
