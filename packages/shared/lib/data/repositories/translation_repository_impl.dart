import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/translation_remote_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/repositories/translation_repository.dart';

@Injectable(as: TranslationRepository)
class const TranslationRepositoryImpl(
  final TranslationRemoteDataSource _remoteDataSource,
) implements TranslationRepository {
  @override
  Future<AppResult<String>> translate({
    required String text,
    required LanguagePair languages,
  }) async {
    try {
      return Success(
        await _remoteDataSource.translate(
          text: text,
          sourceLanguage: languages.source.toLanguageCode(),
          targetLanguage: languages.target.toLanguageCode(),
        ),
      );
    } on Object catch (error) {
      return Failure(error.toServiceError());
    }
  }
}
