import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/translation_remote_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/repositories/translation_repository.dart';

@Injectable(as: TranslationRepository)
class const TranslationRepositoryImpl(
  final TranslationRemoteDataSource _remoteDataSource,
) implements TranslationRepository {
  @override
  Future<AppResult<String>> translate({
    required String text,
    required Language from,
    required Language to,
    String? context,
  }) async {
    try {
      return Success(
        await _remoteDataSource.translate(
          text: text,
          sourceLanguage: from.toLanguageCode(),
          targetLanguage: to.toLanguageCode(),
          context: context,
        ),
      );
    } on Object catch (error) {
      return Failure(error.toServiceError());
    }
  }

  @override
  Future<AppResult<List<String>>> translateBatch({
    required List<String> texts,
    required Language from,
    required Language to,
  }) async {
    try {
      return Success(
        await _remoteDataSource.translateBatch(
          texts: texts,
          sourceLanguage: from.toLanguageCode(),
          targetLanguage: to.toLanguageCode(),
        ),
      );
    } on Object catch (error) {
      return Failure(error.toServiceError());
    }
  }
}
