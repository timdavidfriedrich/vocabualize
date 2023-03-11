import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/reports/services/report_type.dart';

class ReportArguments {
  final ReportType reportType;
  Vocabulary vocabulary = Vocabulary.empty();

  ReportArguments({required this.reportType});
  ReportArguments.bug() : reportType = ReportType.bug;
  ReportArguments.translation({required this.vocabulary}) : reportType = ReportType.translation;
}
