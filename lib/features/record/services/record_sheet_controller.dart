import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';

class RecordSheetController extends SnappingSheetController {
  static final RecordSheetController _recordSheetController = RecordSheetController();
  static get instance => _recordSheetController;

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
    Provider.of<ActiveProvider>(Keys.context, listen: false).typeIsActive = false;
    Provider.of<ActiveProvider>(Keys.context, listen: false).micIsActive = false;
  }
}
