import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

final recordSheetControllerProvider = Provider((ref) => RecordSheetController());

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
}
