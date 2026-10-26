import 'package:serverpod/serverpod.dart';

import '../domain/report_service.dart';
import '../generated/protocol.dart';

class ReportEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<void> sendFeedback(
    Session session,
    String message,
    RemoteReportContext context,
  ) => const ReportService().sendFeedback(session, message: message, context: context);

  Future<void> sendTranslationReport(
    Session session,
    String source,
    String target,
    String sourceLanguage,
    String targetLanguage,
    String note,
    RemoteReportContext context,
  ) => const ReportService().sendTranslationReport(
    session,
    source: source,
    target: target,
    sourceLanguage: sourceLanguage,
    targetLanguage: targetLanguage,
    note: note,
    context: context,
  );
}
