import 'package:vocabualize/src/features/reports/domain/entities/report_type.dart';

class Report {
  final bool done;

  Report({
    this.done = false,
    date,
  });

  factory Report.fromType({required ReportType type}) {
    switch (type) {
      case ReportType.bug:
        return BugReport();
      case ReportType.translation:
        return TranslationReport();
      default:
        return Report();
    }
  }
}

class BugReport extends Report {
  final String description;
  final String? data;

  BugReport({
    this.description = "",
    this.data,
  });
}

class TranslationReport extends Report {
  final String source;
  final String target;
  final String sourceLanguageId;
  final String targetLanguageId;
  final String description;

  TranslationReport({
    this.source = "",
    this.target = "",
    this.sourceLanguageId = "",
    this.targetLanguageId = "",
    this.description = "",
  });
}
