import 'package:core/error/app_result.dart';

abstract class TranslationFillRepository {
  Future<AppResult<int>> fillMissingTranslations();
}
