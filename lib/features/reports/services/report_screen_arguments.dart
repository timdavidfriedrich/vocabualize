import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/reports/services/report_type.dart';

class ReportScreenArguments {
  final ReportType reportType;
  Vocabulary vocabulary = Vocabulary.empty();

  ReportScreenArguments({required this.reportType});
  ReportScreenArguments.bug() : reportType = ReportType.bug;
  ReportScreenArguments.translation({required this.vocabulary}) : reportType = ReportType.translation;
}
