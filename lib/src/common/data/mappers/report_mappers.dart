import 'package:pocketbase/pocketbase.dart';
import 'package:vocabualize/src/common/data/models/rdb_bug_report.dart';
import 'package:vocabualize/src/common/data/models/rdb_translation_report.dart';
import 'package:vocabualize/src/common/domain/entities/report.dart';

extension RdbBugReportMappers on RdbBugReport {
  RecordModel toRecordModel() {
    return RecordModel(
      id: id,
      data: {
        "done": done,
        "description": description,
        "data": data,
        "created": created,
        "updated": updated,
      },
    );
  }
}

extension RdbTranslationReportMappers on RdbTranslationReport {
  RecordModel toRecordModel() {
    return RecordModel(
      id: id,
      data: {
        "done": done,
        "source": source,
        "target": target,
        "sourceLanguage": sourceLanguage,
        "targetLanguage": targetLanguage,
        "description": description,
        "created": created,
        "updated": updated,
      },
    );
  }
}

extension BugReportMappers on BugReport {
  RdbBugReport toRdbBugReport() {
    return RdbBugReport(
      done: done,
      description: description,
      data: data,
    );
  }
}

extension TranslationReportMappers on TranslationReport {
  RdbTranslationReport toRdbTranslationReport() {
    return RdbTranslationReport(
      done: done,
      source: source,
      target: target,
      sourceLanguage: sourceLanguageId,
      targetLanguage: targetLanguageId,
      description: description,
    );
  }
}
