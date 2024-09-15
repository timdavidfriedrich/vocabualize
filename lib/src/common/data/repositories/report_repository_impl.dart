import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/report_mappers.dart';
import 'package:vocabualize/src/common/domain/entities/report.dart';
import 'package:vocabualize/src/common/domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final RemoteDatabaseDataSource _remoteDatabaseDataSource = sl.get<RemoteDatabaseDataSource>();

  @override
  Future<void> sendReport(Report report) {
    switch (report.runtimeType) {
      case const (BugReport):
        return _remoteDatabaseDataSource.sendBugReport((report as BugReport).toRdbBugReport());
      case const (TranslationReport):
        return _remoteDatabaseDataSource.sendTranslationReport((report as TranslationReport).toRdbTranslationReport());
      default:
        throw Exception("Unknown report type: ${report.runtimeType}");
    }
  }
}
