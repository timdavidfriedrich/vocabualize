import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/report.dart';
import 'package:vocabualize/src/common/domain/repositories/report_repository.dart';

class SendReportUseCase {
  final _reportRepository = sl.get<ReportRepository>();

  Future<void> call(Report report) {
    return _reportRepository.sendReport(report);
  }
}
