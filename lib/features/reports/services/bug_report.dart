import 'package:vocabualize/features/reports/services/report.dart';

class BugReport extends Report {
  final String description;

  BugReport({required this.description});
  BugReport.empty() : description = "";

  @override
  Map<String, dynamic> toJson() => {
        "description": description,
        "date": date,
      };
}
