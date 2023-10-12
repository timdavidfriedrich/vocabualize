import 'package:vocabualize/features/reports/models/report.dart';

class TranslationReport extends Report {
  final String source;
  final String target;
  final String description;

  TranslationReport({required this.source, required this.target, this.description = ""});
  TranslationReport.empty()
      : source = "",
        target = "",
        description = "";

  @override
  Map<String, dynamic> toJson() => {
        "source": source,
        "target": target,
        "description": description,
        "date": date,
      };
}
