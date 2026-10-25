import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

abstract class StockImageRepository {
  Future<AppResult<List<StockImage>>> search({
    required String query,
    required Language language,
  });
}
