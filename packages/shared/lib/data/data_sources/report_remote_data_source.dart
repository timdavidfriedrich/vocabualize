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
