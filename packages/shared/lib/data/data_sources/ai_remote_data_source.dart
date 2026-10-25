import 'package:injectable/injectable.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class AiRemoteDataSource {
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  });

  Future<List<RemoteStockImage>> searchStockImages({
    required String query,
    required String language,
  });
}

@Injectable(as: AiRemoteDataSource)
class const AiRemoteDataSourceImpl(
  final Client _client,
) implements AiRemoteDataSource {
  @override
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) => _client.ai.translate(text, sourceLanguage, targetLanguage);

  @override
  Future<List<RemoteStockImage>> searchStockImages({
    required String query,
    required String language,
  }) => _client.ai.searchStockImages(query, language);
}
