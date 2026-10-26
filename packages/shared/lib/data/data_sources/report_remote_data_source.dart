import 'package:injectable/injectable.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class ReportRemoteDataSource {
  Future<void> sendFeedback({
    required String message,
    required RemoteReportContext context,
  });

  Future<void> sendTranslationReport({
    required String source,
    required String target,
    required String sourceLanguage,
    required String targetLanguage,
    required String note,
    required RemoteReportContext context,
  });
}

@Injectable(as: ReportRemoteDataSource)
class const ReportRemoteDataSourceImpl(
  final Client _client,
) implements ReportRemoteDataSource {
  @override
  Future<void> sendFeedback({
    required String message,
    required RemoteReportContext context,
  }) => _client.report.sendFeedback(message, context);

  @override
  Future<void> sendTranslationReport({
    required String source,
    required String target,
    required String sourceLanguage,
    required String targetLanguage,
    required String note,
    required RemoteReportContext context,
  }) => _client.report.sendTranslationReport(
    source,
    target,
    sourceLanguage,
    targetLanguage,
    note,
    context,
  );
}
