import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/ai_remote_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/stock_image_mappers.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/repositories/stock_image_repository.dart';

@Injectable(as: StockImageRepository)
class const StockImageRepositoryImpl(
  final AiRemoteDataSource _remoteDataSource,
) implements StockImageRepository {
  @override
  Future<AppResult<List<StockImage>>> search({
    required String query,
    required Language language,
  }) async {
    try {
      final images = await _remoteDataSource.searchStockImages(
        query: query,
        language: language.toLanguageCode(),
      );
      return Success([for (final image in images) image.toStockImage()]);
    } on Object catch (error) {
      return Failure(error.toAiError());
    }
  }
}
