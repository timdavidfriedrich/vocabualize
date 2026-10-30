import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';

abstract class TranslationRepository {
  Future<AppResult<String>> translate({
    required String text,
    required Language from,
    required Language to,
    String? context,
  });

  Future<AppResult<List<String>>> translateBatch({
    required List<String> texts,
    required Language from,
    required Language to,
  });
}
