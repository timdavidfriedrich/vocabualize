import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/reports/models/report.dart';

class TranslationReport extends Report {
  final String source;
  final String target;
  final Language sourceLanguage;
  final Language targetLanguage;
  final String description;

  TranslationReport({
    required this.source,
    required this.target,
    required this.sourceLanguage,
    required this.targetLanguage,
    this.description = "",
  });
  TranslationReport.empty()
      : source = "",
        target = "",
        description = "",
        sourceLanguage = Language.defaultSource(),
        targetLanguage = Language.defaultTarget();

  @override
  Map<String, dynamic> toJson() => {
        "done": done,
        "source": source,
        "target": target,
        "sourceLanguage": sourceLanguage.id,
        "targetLanguage": targetLanguage.id,
        "description": description,
      };
}
