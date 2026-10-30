import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/service_access_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class TranslationRemoteDataSource {
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  });

  Future<List<String>> translateBatch({
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
  });
}

@Injectable(as: TranslationRemoteDataSource)
class const TranslationRemoteDataSourceImpl(
  final Client _client,
  final ServiceAccessDataSource _serviceAccess,
) implements TranslationRemoteDataSource {
  @override
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  }) => _serviceAccess.run(
    (installKey) => _client.translation.translate(
      text,
      sourceLanguage,
      targetLanguage,
      context,
      installKey,
    ),
  );

  @override
  Future<List<String>> translateBatch({
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
  }) => _serviceAccess.run(
    (installKey) => _client.translation.translateBatch(
      texts,
      sourceLanguage,
      targetLanguage,
      installKey,
    ),
  );
}
