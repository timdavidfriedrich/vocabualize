import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/report_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/report.dart';
import 'package:vocabualize/src/common/domain/repositories/report_repository.dart';

final sendReportUseCaseProvider = AutoDisposeProvider((ref) {
  return SendReportUseCase(
    reportRepository: ref.watch(reportRepositoryProvider),
  );
});

class SendReportUseCase {
  final ReportRepository _reportRepository;

  const SendReportUseCase({
    required ReportRepository reportRepository,
  }) : _reportRepository = reportRepository;

  Future<void> call(Report report) {
    return _reportRepository.sendReport(report);
  }
}
