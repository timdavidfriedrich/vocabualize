import 'package:vocabualize/features/reports/models/report.dart';

class BugReport extends Report {
  final String description;
  final String? data;

  BugReport({required this.description, this.data});
  BugReport.empty()
      : description = "",
        data = null;

  @override
  Map<String, dynamic> toJson() => {
        "done": done,
        "description": description,
        "data": data,
      };
}
