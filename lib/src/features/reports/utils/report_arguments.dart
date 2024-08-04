import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/reports/utils/report_type.dart';

class ReportArguments {
  final ReportType reportType;
  Vocabulary vocabulary = Vocabulary.empty();

  ReportArguments({required this.reportType});
  ReportArguments.bug() : reportType = ReportType.bug;
  ReportArguments.translation({required this.vocabulary}) : reportType = ReportType.translation;
}
