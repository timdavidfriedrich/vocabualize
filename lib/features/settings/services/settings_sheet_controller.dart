import 'package:flutter/animation.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SettingsSheetController extends SnappingSheetController {
  show() {
    snapToPosition(
      const SnappingPosition.factor(
        positionFactor: 0.25,
        snappingCurve: ElasticOutCurve(0.9),
        snappingDuration: Duration(milliseconds: 1000),
      ),
    );
  }
}
