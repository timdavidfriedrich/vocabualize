import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabualize/src/features/reports/utils/report_type.dart';

// TODO ARCHITECTURE: Check if Report class is fine
class Report {
  final bool done = false;
  final Timestamp date = Timestamp.now();

  Report();
  factory Report.fromType({required ReportType type}) {
    switch (type) {
      case ReportType.bug:
        return BugReport.empty();
      case ReportType.translation:
        return TranslationReport.empty();
      default:
        return Report();
    }
  }

  String get formattedDate {
    String year = date.toDate().year.toString().padLeft(4, "0");
    String month = date.toDate().month.toString().padLeft(2, "0");
    String day = date.toDate().day.toString().padLeft(2, "0");
    return "$year$month$day";
  }

  String get formattedDateDetailed {
    String hour = date.toDate().hour.toString().padLeft(2, "0");
    String minute = date.toDate().minute.toString().padLeft(2, "0");
    String second = date.toDate().second.toString().padLeft(2, "0");
    String millisecond = date.toDate().millisecond.toString().padLeft(3, "0");
    String microsecond = date.toDate().microsecond.toString().padLeft(3, "0");
    return "$formattedDate-$hour-$minute-$second-$millisecond-$microsecond";
  }

  Map<String, dynamic> toJson() {
    return {
      'default': "default",
    };
  }
}

class BugReport extends Report {
  final String description;
  final String? data;

  BugReport({required this.description, this.data});
  BugReport.empty()
      : description = "",
        data = null;

  @override
  Map<String, dynamic> toJson() {
    return {
      "done": done,
      "description": description,
      "data": data,
    };
  }
}

class TranslationReport extends Report {
  final String source;
  final String target;
  final String sourceLanguageId;
  final String targetLanguageId;
  final String description;

  TranslationReport({
    required this.source,
    required this.target,
    required this.sourceLanguageId,
    required this.targetLanguageId,
    this.description = "",
  });
  TranslationReport.empty()
      : source = "",
        target = "",
        description = "",
        sourceLanguageId = "",
        targetLanguageId = "";
}
