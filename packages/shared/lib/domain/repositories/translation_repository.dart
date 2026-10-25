import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language_pair.dart';

abstract class TranslationRepository {
  Future<AppResult<String>> translate({
    required String text,
    required LanguagePair languages,
  });
}
