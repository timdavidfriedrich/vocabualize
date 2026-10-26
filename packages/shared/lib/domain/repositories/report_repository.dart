import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language_pair.dart';

abstract class ReportRepository {
  Future<AppResult<()>> sendFeedback(String message);

  Future<AppResult<()>> sendTranslationReport({
    required String source,
    required String target,
    required LanguagePair languages,
    required String note,
  });
}
