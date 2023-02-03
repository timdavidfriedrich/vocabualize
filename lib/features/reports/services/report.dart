import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabualize/features/reports/services/bug_report.dart';
import 'package:vocabualize/features/reports/services/report_type.dart';
import 'package:vocabualize/features/reports/services/translation_report.dart';

class Report {
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

  Map<String, dynamic> toJson() => {
        'default': "default",
      };
}
