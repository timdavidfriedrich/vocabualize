import 'package:vocabualize/src/common/domain/entities/report.dart';

abstract interface class ReportRepository {
  Future<void> sendReport(Report report);
}
